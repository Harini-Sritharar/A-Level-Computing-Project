import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  final String msg;
  final void Function() linkScreen;
  const GenericButton(this.msg, this.linkScreen, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    return ElevatedButton(
      onPressed: linkScreen,
      child: Text(
        msg,
        textAlign: TextAlign.center,
        style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      autofocus: true,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
        minimumSize: MaterialStateProperty.all(const Size(250, 60)),
      ),
    );
  }
}

class QuizButton extends StatelessWidget {
  final String txt;
  final a;
  const QuizButton(this.txt, this.a);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(txt),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white10)),
      onPressed: a,
    );
  }
}

class LoginButton extends StatelessWidget {
  final String txt;

  const LoginButton(this.txt);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          color: Colors.cyan[400], borderRadius: BorderRadius.circular(30)),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width - 40,
      child: Text(txt,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}

// class TealButton extends StatelessWidget{

// }