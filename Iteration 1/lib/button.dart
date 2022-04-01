import 'package:flutter/material.dart';
import 'package:nea_prototype_1/main.dart';

class GenericButton extends StatelessWidget {
  // parameters for the Generic Button
  final String msg;
  final void Function() linkScreen;
  // constructors for the Generic Button
  const GenericButton(this.msg, this.linkScreen, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: linkScreen,
      child: Text(
        msg,
        textAlign: TextAlign.center,
        style: constants.genericButtonStyle
            .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
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
  // parameters for the Quiz Button
  final String txt;
  final a;
  // constructors for the Quiz Button
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
  // parameters for the Login Button
  final String txt;
  final Function() onClick;
  // constructor for the Login Button
  const LoginButton(this.txt, this.onClick);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
              color: Colors.cyan[400], borderRadius: BorderRadius.circular(30)),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width - 40,
          child: Text(txt,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        onTap: onClick);
  }
}

class CircleButton extends StatelessWidget {
  // parameters for the Circle Button
  final String text;
  final Function() onPressed;
  // constructor for the Circle Button
  const CircleButton(this.text, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: ElevatedButton(
            child:
                Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(100, 100), shape: const CircleBorder())));
  }
}
