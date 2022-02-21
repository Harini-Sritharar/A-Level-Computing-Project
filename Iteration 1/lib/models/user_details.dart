import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nea_prototype_1/services/database.dart';

class UserDetails {
  String uid, name = "", email = "", position = "", classId = "";
  int yearGroup = 11;

  UserDetails(this.uid);

  Future<void> fillBasicData() async {
    
    //opens the Users collection
    DocumentSnapshot document =
        await Firestore.instance.collection("Users").document(uid).get();
    Map<String, dynamic> data =
        document.data as Map<String, dynamic>;
    print(data);
    name = data['name'];
    email = data['email'];
    position = data['position'];
    classId = data['classId'];
    yearGroup = data['yearGroup'];
  }






}
