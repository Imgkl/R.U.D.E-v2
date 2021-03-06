import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rude/common_widgets/app_bar.dart';
import 'package:rude/common_widgets/rude_text.dart';
import 'package:rude/services/firestore_service.dart';
import 'package:rude/services/shared_pref.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:wiredash/wiredash.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  TimeOfDay startTime = TimeOfDay(hour: 22, minute: 00);
  TimeOfDay endTime = TimeOfDay(hour: 9, minute: 00);
  int val = 1;
  String uid;

  startTimeChanged(TimeOfDay newTime) {
    setState(() {
      startTime = newTime;
    });
  }

  endTimeChanged(TimeOfDay newTime) {
    setState(() {
      endTime = newTime;
    });
  }

  @override
  void initState() {
    LocalStorage.getTimeInterval();
    print(LocalStorage.getTimeInterval());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final user = context.watchSignedInUser();
    user.map(
      (value) async {
        setState(() {
          uid = value.user.uid;
        });
        LocalStorage.setEmail(value.user.email);
        Wiredash.of(context).setUserProperties(
          userEmail: value.user.email,
        );
        FirestoreService(uid: value.user.uid).updateUserProfile(
            value.user.displayName, value.user.email, value.user.photoUrl);
      },
      empty: (_) {},
      initializing: (_) {},
    );
    super.didChangeDependencies();
  }

  upDateData() {
    LocalStorage.setTimeInterval(this.val);
    Firestore.instance.collection("user-profiles").document(uid).updateData({
      "timeInterval": this.val,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        uid: uid,
      ),
      backgroundColor: Color(0xff373846),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      val != 0
                          ? "Every Hour You'll Get"
                          : "Didn't ask for your IQ",
                      style: TextStyle(fontSize: 38, color: Colors.white),
                    ),
                    StepperSwipe(
                      initialValue: LocalStorage.getTimeInterval(),
                      firstIncrementDuration: Duration(milliseconds: 100),
                      dragButtonColor: Color(0xffE2B778),
                      counterTextColor: Colors.black,
                      iconsColor: Colors.black,
                      withSpring: true,
                      maxValue: 6,
                      stepperValue: val,
                      withNaturalNumbers: true,
                      onChanged: (int val) {
                        setState(() {
                          this.val = val;
                        });
                        upDateData();
                      },
                    ),
                    Text(
                      val == 0 ? "" : val == 1 ? "Notification" : "Notifications",
                      style: TextStyle(fontSize: 42, color: Colors.white),
                    ),
                  ],
                ),
              ),
              if (val == 6) RudeMessage(text: "Gonna crush you, just like you crushed your parents hope."),
              if (val == 5) RudeMessage(text: "Strong? You gonna regret this."),
              if (val == 4) RudeMessage(text: "Destroyed, you will be"),
              if (val == 3)
                RudeMessage(text: "Now we are talking!"),
              if (val == 2) RudeMessage(text: "Meh"),
              if (val == 1) RudeMessage(text: "Why are you even doing this?"),
              if (val == 0) RudeMessage(text: "Dumb."),
            ],
          ),
        ],
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xffE5CA97),
          Color(0xffd59a4f),
        ])),
        height: 100,
        width: double.infinity,
        child: FlatButton(
          onPressed: () {
            displayBottomSheet(context);
          },
          child: Text(
            "DND Settings",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        backgroundColor: Color(0xff373846),
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "Choose your preferred DND setting, I hope you know the full form for DND! 🤪",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      showPicker(
                                        accentColor: Color(0xffE2B778),
                                        blurredBackground: true,
                                        context: context,
                                        value: startTime,
                                        onChange: startTimeChanged,
                                        onChangeDateTime: (DateTime dateTime) {
                                          print(dateTime.toLocal());
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Color(0xffE5CA97),
                                      Color(0xffd59a4f),
                                    ])),
                                    child: Icon(FontAwesomeIcons.moon),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Text(
                                    "${startTime.hourOfPeriod.toString()} : ${(startTime.minute == 0) ? "${startTime.minute.toString()}0" : startTime.minute.toString()} ${(startTime.hour >= 00 && startTime.hour <= 11) ? "AM" : "PM"}",
                                    style: TextStyle(color: Colors.white)),
                              )
                            ],
                          ),
                          // Text("TO", style: TextStyle(color: Colors.white),),
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      showPicker(
                                        accentColor: Color(0xffE2B778),
                                        blurredBackground: true,
                                        context: context,
                                        value: endTime,
                                        onChange: endTimeChanged,
                                        onChangeDateTime: (DateTime dateTime) {
                                          setState(() {
                                            // endTime =
                                            //     dateTime.hour as TimeOfDay;
                                            print(endTime);
                                          });
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Color(0xffE5CA97),
                                      Color(0xffd59a4f),
                                    ])),
                                    width: 70,
                                    child: Icon(FontAwesomeIcons.sun),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Text(
                                    "${endTime.hourOfPeriod.toString()} : ${(endTime.minute == 0) ? "${endTime.minute.toString()}0" : endTime.minute.toString()} ${(endTime.hour >= 12 && endTime.hour <= 23) ? "PM" : "AM"}",
                                    style: TextStyle(color: Colors.white)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    OutlineButton(
                      highlightedBorderColor: Color(0xffC29543),
                      focusColor: Color(0xffC29543),
                      splashColor: Color(0xffC29543),
                      shape: new RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xffC29543)),
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      borderSide: BorderSide(color: Color(0xffC29543)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Close",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
