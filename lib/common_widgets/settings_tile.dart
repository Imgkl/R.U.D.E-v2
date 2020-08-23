import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final Function callback;
  final String label;
  final IconData icon;
  final Color color;
  final bool last;

  const SettingsTile(
      {Key key,
      this.callback,
      this.label,
      this.icon,
      this.color,
      this.last = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => callback(),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: color,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    label,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: last
                ? Container()
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: LinearGradient(colors: [
                        Color(0xffE5CA97),
                        Color(0xffd59a4f),
                      ]),
                    ),
                    child: Divider(
                      thickness: 1,
                      height: 2,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
