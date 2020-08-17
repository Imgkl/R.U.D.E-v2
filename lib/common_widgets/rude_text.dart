import 'dart:async';

import 'package:flutter/material.dart';

class RudeMessage extends StatefulWidget {
  final String text;

  const RudeMessage({Key key, this.text}) : super(key: key);

  @override
  _RudeMessageState createState() => _RudeMessageState();
}

class _RudeMessageState extends State<RudeMessage> {
  double showWidget = 0.0;

  @override
  void didUpdateWidget(RudeMessage oldWidget) {
    Timer(Duration(milliseconds: 500), (){
      setState(() {
            showWidget = 1.0;
          });
          Future.delayed(Duration(seconds: 2), (){
            setState(() {
              showWidget = 0.0;
            });
          });
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:48.0, left: 15, right: 15),
      child: AnimatedOpacity(
        duration: Duration(seconds: 1),
        opacity: showWidget,
            child: Container(
              child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "🤖",
                  style: TextStyle(fontSize: 24),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      widget.text ?? "",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ],
          ),
        ),
            ),
      ),
    );
  }
}
