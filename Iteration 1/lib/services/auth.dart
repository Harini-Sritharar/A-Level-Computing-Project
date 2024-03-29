import 'package:firebase_auth/firebase_auth.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/models/user_details.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserDetails? _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? UserDetails(user.uid) : null;
  }

  // logs into existing account
  Future<UserDetails?> signInEmailAndPassword(String email, String password) async {
    //try to log the user in with the email and password provided
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      // else catch the error and print it to the console
      print(e.toString());
    }
  }

  // creates a new account
  Future signUpWithEmailAndPassword(String email, String password) async {
    //try to create a new user with the email and password provided
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      print("User Added");
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      // else catch the error and print it to the console
      print(e.toString());
    }
  }

  // signing out
  Future signOut() async {
    // try to sign the user out and then set appUser to null
    try {
      appUser = null;
      return await _auth.signOut();
    } catch (e) {
      // else catch the error and print it to the console
      print(e.toString());
      return null;
    }
  }

  // static String userLoggedInKey = "USERKEY";
  // //for saving
  // static saveUserLoggedIn({required bool isLoggedIn}) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setBool(userLoggedInKey, isLoggedIn);
  // }

  // //for retrieving
  // static Future<bool> getUserLoggedIn() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   return preferences.getBool(userLoggedInKey);
  // }
}
