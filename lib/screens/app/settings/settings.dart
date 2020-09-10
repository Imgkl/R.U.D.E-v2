import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:overlay/overlay.dart';
import 'package:rude/screens/app/profile.dart';
import 'package:rude/screens/app/settings/rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wiredash/wiredash.dart';

class Settings extends StatefulWidget {
  final String uid;
  final String testNotification;

  const Settings({Key key, this.uid, this.testNotification}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool isOnLeft(double rotation) => math.cos(rotation) > 0;

  @override
  Widget build(BuildContext context) {
    final numberOfTexts = 20;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              alignment: Alignment.center,
              children: List.generate(
                numberOfTexts,
                (index) {
                  return AnimatedBuilder(
                    animation: _animationController,
                    child: LinearText(),
                    builder: (context, child) {
                      final animationRotationValue =
                          _animationController.value *
                              2 *
                              math.pi /
                              numberOfTexts;
                      double rotation = 2 * math.pi * index / numberOfTexts +
                          math.pi / 2 +
                          animationRotationValue;
                      if (isOnLeft(rotation)) {
                        rotation = -rotation +
                            2 * animationRotationValue -
                            math.pi * 2 / numberOfTexts;
                      }
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(rotation)
                          ..translate(-120.0),
                        child: LinearText(),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SettingsTile(
                        iconColor: Colors.pink,
                        label: "Profile",
                        icon: FontAwesomeIcons.user,
                        callback: () {
                          CustomOverlay(
                            context: context,
                            overlayWidget: ProfileCard(uid: widget.uid),
                          );
                        },
                      ),
                      SettingsTile(
                        iconColor: Colors.blue,
                        label: "Test\nNotification",
                        icon: FontAwesomeIcons.flask,
                        callback: () {
                          Navigator.pop(context);
                          Future.delayed(Duration(seconds: 1));
                          Flushbar(
                            margin: EdgeInsets.all(8),
                            isDismissible: true,
                            borderRadius: 10,
                            flushbarStyle: FlushbarStyle.FLOATING,
                            flushbarPosition: FlushbarPosition.TOP,
                            message: widget.testNotification,
                            duration: Duration(seconds: 10),
                          )..show(context);
                        },
                      ),
                      SettingsTile(
                        iconColor: Colors.green,
                        label: "Privacy Policy",
                        icon: FontAwesomeIcons.file,
                        callback: () {
                          launch("https://rude-0.flycricket.io/privacy.html",
                              forceSafariVC: true, forceWebView: true);
                        },
                      ),
                      SettingsTile(
                        iconColor: Colors.cyan,
                        label: "Feedback",
                        icon: FontAwesomeIcons.comment,
                        callback: () {
                          Wiredash.of(context).show();
                        },
                      ),
                      SettingsTile(
                        iconColor: Colors.teal,
                        label: "Rate my app",
                        icon: FontAwesomeIcons.smile,
                        callback: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RateMyApp()));
                        },
                      ),
                      SettingsTile(
                        iconColor: Colors.red,
                        label: "Log Out",
                        icon: FontAwesomeIcons.powerOff,
                        callback: () {
                          context.signOut();
                          Navigator.popAndPushNamed(context, "/onboard");
                        },
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final callback;

  const SettingsTile(
      {Key key,
      this.label,
      this.icon,
      this.callback,
      this.iconColor = Colors.black})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffE5CA97), Color(0xffd59a4f)]),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 150,
        width: 110,
        child: InkWell(
          onTap: () => callback(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 3,
                  child: Icon(
                    icon,
                    color: iconColor,
                  )),
              Expanded(
                  flex: 2,
                  child: Text(
                    label,
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class LinearText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Container(
        child: Text(
          'R.U.D.E',
          style: TextStyle(
            color: Colors.white,
            fontSize: 110,
          ),
        ),
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.9),
              Colors.transparent
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.0, 0.2, 0.8],
          ),
        ),
      ),
    );
  }
}
