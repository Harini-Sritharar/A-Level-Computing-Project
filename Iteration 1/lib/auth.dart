import 'package:firebase_auth/firebase_auth.dart';
import 'package:nea_prototype_1/user_model.dart';

class AuthService{
  FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(userId: user.userId): null;
  }
  // logs into existing account
  Future loginEmailAndPassword(String email,String password) async{
    
    try{
      AuthResult authResult = await _auth.loginWithEmailAndPassword
      (email: email, password:password);
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser);
    }
    catch (e){
      print(e.toString());
    }
  }
  // creates a new account
   Future signUpWithEmailAndPassword(String email, String password) async{
     try{
      AuthResult authResult = await _auth.createUserWithEmailAndPassword
      (email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser);
    }
    catch (e){
      print(e.toString());
    }
   }
}