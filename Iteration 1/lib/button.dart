import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  final String msg;
  final void Function() linkScreen;
  const GenericButton(this.msg, this.linkScreen, { Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    return Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xFF26A69A), // color of login button
        child: MaterialButton(
          //minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: linkScreen,
          child: Text(
            msg,
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
  }
}
