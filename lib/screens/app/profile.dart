import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slimy_card/slimy_card.dart';

class ProfileCard extends StatefulWidget {
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => SlimyCard(
        // color: Color(0xff373846),
        color: Color(0xffE2B778),
        width: 350,
        topCardHeight: 400,
        bottomCardHeight: 200,
        borderRadius: 15,
        topCardWidget: topCard(context),
        bottomCardWidget: bottomCard(),
        slimeEnabled: true,
      ),
    );
  }
}

Widget topCard(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        child: CircleAvatar(
          radius: 70,
          backgroundColor: Color(0xff373846),
          foregroundColor: Colors.transparent,
          child: Icon(
            FontAwesomeIcons.user,
            color: Colors.white,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Material(
          type: MaterialType.transparency,
          child: Text("Name",
              style: TextStyle(
                fontSize: 34,
              )),
        ),
      )
    ],
  );
}

Widget bottomCard() {
  return Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Material(
          type: MaterialType.transparency,
          child: Text("Some other data",
              style: TextStyle(
                fontSize: 24,
              )),
        ),
      );
}
