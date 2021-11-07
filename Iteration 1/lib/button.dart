import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  final String msg;
  final void Function() linkScreen;
  const GenericButton(this.msg, this.linkScreen, { Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    return ElevatedButton(
      onPressed: linkScreen,
      child: Text(
            msg,
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          autofocus: true);

  }
}
