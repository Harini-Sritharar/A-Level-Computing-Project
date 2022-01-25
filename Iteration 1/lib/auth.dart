import 'package:firebase_auth/firebase_auth.dart';
import 'package:nea_prototype_1/user_model.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? _userFromFirebaseUser(FirebaseUser user){
    return user != null ? MyUser(uid: user.uid) : null;
  }
  // logs into existing account
  Future signInEmailAndPassword(String email,String password) async{
    try{
      AuthResult authResult = await _auth.signInWithEmailAndPassword
      (email: email, password: password);
    
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
      print("User Added");
      return _userFromFirebaseUser(firebaseUser);

    }
    catch (e){
      print(e.toString());
    }
   }
   // signing out
   Future signOut() async{
     try{
       return await _auth.signOut();
     }
     catch(e){
       print(e.toString());
       return null;
     }
   }
}