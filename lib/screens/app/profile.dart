import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slimy_card/slimy_card.dart';

class ProfileCard extends StatefulWidget {
  final String uid;

  const ProfileCard({Key key, this.uid}) : super(key: key);
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  DocumentSnapshot userProfile;

  @override
  void initState() {
    Firestore.instance
        .collection("user-profiles")
        .document(widget.uid)
        .get()
        .then((ds) {
      setState(() {
        userProfile = ds;
      });
    });
    super.initState();
  }

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
        
        topCardWidget: topCard(context, userProfile),
        bottomCardWidget: bottomCard(),
        slimeEnabled: true,
      ),
    );
  }
}

Widget topCard(context, userProfile) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        child: CircleAvatar(
          radius: 70,
          backgroundColor: Color(0xff373846),
          foregroundColor: Colors.transparent,
          backgroundImage: NetworkImage((userProfile!=null&& userProfile.data["photoUrl"] !=null) ?userProfile.data["photoUrl"]: "https://dummyimage.com/30x30/373846/fff.png&text=+"),
          child: (userProfile!=null && userProfile.data["photoUrl"] == null)? Icon(
            FontAwesomeIcons.user,
            color: Colors.white,
          ): Container(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Material(
          type: MaterialType.transparency,
          child: Text((userProfile!=null&& userProfile.data["name"] !=null) ? userProfile.data["name"]: "Anonymous",
              style: TextStyle(
                fontSize:(userProfile!=null&& userProfile.data["name"] !=null)? 34: 24,
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
