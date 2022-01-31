import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  //final myController = TextEditingController();
  // NameField({ Key? key }) : super(key: key);
  String label;
  String info;
  TextEditingController myController;
  CustomTextField(this.label, this.info,this.myController);
  Widget build(BuildContext context) {
  //   TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    return TextFormField(
      controller: myController,
      validator: (val) {
        return val!.isEmpty ? "Enter" + label : null;
       },
        decoration: InputDecoration(hintText: label),
        onChanged: (val) {
        info = val;
        },
        );
  }}



  // final String label;
  // String info;
  // TextEditingController myController;
  // CustomTextField(this.label, this.info, this.myController);
  // @override
  // Widget build(BuildContext context) {
  //   TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  //   return TextFormField(
  //     controller: myController,
  //     validator: (val) {
  //       return val!.isEmpty ? "Enter" + label : null;
  //     },
  //     obscureText: false,
  //     style: style,
  //     decoration: InputDecoration(
  //         fillColor: Colors.deepPurple[100],
  //         filled: true,
  //         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
  //         labelText: label,
  //         hintText: "Enter your " + label + " here",
  //         border:
  //             OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  //     onChanged: (val) {
  //       info = val;
  //     },
  //   );
  // }

                        
