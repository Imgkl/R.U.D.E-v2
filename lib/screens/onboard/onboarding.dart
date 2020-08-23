import 'dart:math';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class OnBoard extends StatefulWidget {
  final buildContext;

  const OnBoard({Key key, this.buildContext}) : super(key: key);
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int page = 0;
  LiquidController liquidController;
  UpdateType updateType;
  double sliderPercentage = 0.0;

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  final pages = [
    Container(
      width: double.infinity,
      color: Color(0xff373846),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 2),
            child: Text(
              "Okay, I'll say this right off the bat, This app can be rude...",
              style: TextStyle(fontSize: 72, color: Color(0xffC29543)),
            ),
          )
        ],
      ),
    ),
    Container(
      width: double.infinity,
      color: Color(0xffC29543),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Ready?",
            style: TextStyle(fontSize: 96, color: Color(0xff373846)),
          ),
          Text(
            "😈",
            style: TextStyle(fontSize: 96, color: Color(0xff373846)),
          ),
        ],
      ),
    ),
  ];

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: new Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LiquidSwipe(
            enableLoop: false,
            pages: pages,
            slidePercentCallback: (hp,vp){
              setState(() {
                sliderPercentage = hp;
              });
            },
            initialPage: 0,
            onPageChangeCallback: pageChangeCallback,
            waveType: WaveType.liquidReveal,
            liquidController: liquidController,
            ignoreUserGestureWhileAnimating: true,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(pages.length, _buildDot),
                ),
              ],
            ),
          ),
         if(page == 1 && (sliderPercentage == 100.0 || sliderPercentage == 0.0) ) Padding(
            padding: const EdgeInsets.only(top:308.0),
            child: Align(
              alignment: Alignment.center,
              child: OutlineButton(
                highlightedBorderColor: Color(0xffC29543),
                focusColor: Color(0xffC29543),
                splashColor: Color(0xffC29543),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                borderSide: BorderSide(color: Colors.black),
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/auth");
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "I'm in.",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}
