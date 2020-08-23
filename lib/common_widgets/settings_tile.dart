import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final Function callback;
  final String label;
  final IconData icon;
  final Color color;

  const SettingsTile({Key key, this.callback, this.label, this.icon, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:28.0),
      child: GestureDetector(
        onTap: () => callback(),
        child: Row(
          children: [
            Icon(icon, color: color,),
            Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: Text(label, style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),),
            )
          ],
        ),
      ),
    );
  }
}
