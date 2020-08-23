import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences prefs;

  static Future initilize() async {
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print("${e.toString()}");
    }
  }

  static Future setTimeInterval(timeInterval) async {
    prefs.setInt("timeInterval", timeInterval);
  }

  static Future setEmail(String emailID) async {
    prefs.setString("email", emailID);
  }


  static getTimeInterval() {
    var status =
        prefs.getInt("timeInterval") != null ? prefs.getInt("timeInterval") : "1";
    return status;
  }

  static String getEmailID() {
    String email =
        prefs.getString("email") != null ? prefs.getString("email") : "";
    return email;
  }

}
