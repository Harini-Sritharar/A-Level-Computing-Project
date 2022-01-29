import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String userLoggedInKey = "USERKEY";
  //for saving
  static saveUserLoggedIn({required bool isLoggedIn})async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(userLoggedInKey, isLoggedIn);
  }
  //for checking
  static Future<bool> getUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(userLoggedInKey);
  }
}