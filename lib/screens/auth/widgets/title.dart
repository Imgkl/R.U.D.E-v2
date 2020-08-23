import 'package:flutter/material.dart';

class LoginTitle extends StatelessWidget {
  final String hello;
  final String douche;
  final String dude;
  const LoginTitle(this.hello, this.douche, this.dude);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: hello,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
          TextSpan(
            text: "\n$douche" ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.lineThrough,
              fontSize: 34,
            ),
          ),
          TextSpan(
            text: "\n$dude" ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 34,
            ),
          ),
        ],
      ),
    );
  }
}
