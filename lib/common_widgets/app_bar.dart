import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:overlay/overlay.dart';
import 'package:rude/common_widgets/settings_tile.dart';
import 'package:rude/screens/app/profile.dart';
import 'package:wiredash/wiredash.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  @override
  final String uid;
  final Size preferredSize;

  CustomAppBar({
    Key key, this.uid,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
   String testNotification = "test";

  @override
  void initState() {
    Firestore.instance
        .collection('app-settings')
        .document('general')
        .get()
        .then((ds) {
      setState(() {
        this.testNotification = ds.data["testNotification"];
      });
    });
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
            icon: Icon(FontAwesomeIcons.cog),
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 470,
                      decoration: BoxDecoration(
                          color: Color(0xff373846),
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 28.0, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Settings",
                                  style: TextStyle(
                                      fontSize: 34,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    icon: Icon(FontAwesomeIcons.times,
                                        color: Colors.white),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            ),
                            SettingsTile(
                              color: Colors.pink,
                              callback: () {
                                Navigator.pop(context);
                                CustomOverlay(
                                  context: context,
                                  overlayWidget: ProfileCard(uid: widget.uid),
                                );
                              },
                              label: "Profile",
                              icon: FontAwesomeIcons.user,
                            ),
                            SettingsTile(
                              color: Colors.blue,
                              callback: () {
                                Navigator.pop(context);
                                Future.delayed(Duration(seconds: 1));
                                Flushbar(
                                  margin: EdgeInsets.all(8),
                                  isDismissible: true,
                                  borderRadius: 10,
                                  flushbarStyle: FlushbarStyle.FLOATING,
                                  flushbarPosition: FlushbarPosition.TOP,
                                  message: testNotification,
                                  duration: Duration(seconds: 10),
                                )..show(context);
                              },
                              label: "Test notification",
                              icon: FontAwesomeIcons.flask,
                            ),
                            SettingsTile(
                              color: Colors.green,
                              callback: () {},
                              label: "Privacy policy",
                              icon: FontAwesomeIcons.file,
                            ),
                            SettingsTile(
                              color: Colors.yellow,
                              callback: () {
                                Navigator.pop(context);
                                Wiredash.of(context).show();
                              },
                              label: "Feedback",
                              icon: FontAwesomeIcons.comment,
                            ),
                            SettingsTile(
                              color: Colors.red,
                              callback: () {
                                context.signOut();
                                Navigator.pop(context);
                                Navigator.popAndPushNamed(context, "/onboard");
                              },
                              last: true,
                              label: "Log out",
                              icon: FontAwesomeIcons.powerOff,
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
      ],
    );
  }
}
