import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:overlay/overlay.dart';
import 'package:package_info/package_info.dart';
import 'package:rude/common_widgets/settings_tile.dart';
import 'package:rude/screens/app/profile.dart';
import 'package:rude/screens/app/settings/settings.dart';
import 'package:wiredash/wiredash.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  final String uid;
  final Size preferredSize;

  CustomAppBar({
    Key key,
    this.uid,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String testNotification = "test";

  PackageInfo packageInfo = PackageInfo(
      version: 'Unknown', buildNumber: 'Unknown', packageName: "Unknown");

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  @override
  void initState() {
    _initPackageInfo();
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(
                    uid: widget.uid,
                    testNotification: testNotification,
                  ),
                ),
              );
            }),
      ],
    );
  }
}
