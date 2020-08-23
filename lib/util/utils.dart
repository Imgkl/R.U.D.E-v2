import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rude/services/push_notifications.dart';
import 'package:rude/services/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Util {
  static Future 
  initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    LocalStorage.initilize();
    PushNotificationService().initialise();
  }
}
