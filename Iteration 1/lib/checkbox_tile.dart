//import 'dart:html';
import 'package:flutter/material.dart';

class ChoiceBox extends StatefulWidget {
//  final String msg;
//  final void Function(bool?) state;
//  const ChoiceBox ({Key? key, required this.msg, required this.state}): super(key:key);
  //_ChoiceBoxState({Key? key, required this.msg, required this.state}) : super(key: key);
  @override
  //State<ChoiceBox> createState() => _ChoiceBoxState();
  State<ChoiceBox> createState() => ChoiceBoxState();
  //  return _ChoiceBoxState(msg: "");

}

class ChoiceBoxState extends State<ChoiceBox> {
  //  String msg;
  //  void Function(bool?) state;
  //_ChoiceBoxState({Key? key, required this.msg, required this.state}) : super(key: key);

  //_ChoiceBox({Key? key, required this.msg}) : super(key: key);
  //_ChoiceBox(this.msg,this.state);
  //{ Key? key }) : super(key: key);
  final String msg = "";
  //final void Function(bool?) state;
  Widget build(BuildContext context) {
    bool _checkboxTile = false;
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(msg),
      value: _checkboxTile,
      onChanged: (value) {
        setState(() {
          _checkboxTile = !_checkboxTile;
        });
      },
    );
    //@override

    // setState(() {
    // _checkboxTile =! _checkboxTile;
  }
}
