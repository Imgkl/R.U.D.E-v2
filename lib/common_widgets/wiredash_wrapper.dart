import 'package:flutter/material.dart';
import 'package:rude/services/environment_strings.dart';
import 'package:wiredash/wiredash.dart';

class WireDashWrapper extends StatefulWidget {
  final navigatorKey;
  final child;

  const WireDashWrapper({Key key, this.navigatorKey, this.child})
      : super(key: key);
  @override
  _WireDashWrapperState createState() => _WireDashWrapperState();
}

class _WireDashWrapperState extends State<WireDashWrapper> {
  @override
  Widget build(BuildContext context) {
    return Wiredash(
      theme: WiredashThemeData(
        primaryColor: Color(0xffE5CA97),
        secondaryColor: Color(0xffd59a4f),
        dividerColor: Color(0xffffffff),
        primaryBackgroundColor: Color(0xff373846),
        primaryTextColor: Colors.white,
        secondaryBackgroundColor: Color(0xff0e0d10),
        secondaryTextColor: Color(0xffC29543),
      ),
      options: WiredashOptionsData(
        showDebugFloatingEntryPoint: false,
      ),
      secret: EnvironmentConfig.WIREDASH_SECRET_ID,
      projectId: EnvironmentConfig.WIREDASH_PROJECT_ID,
      navigatorKey: widget.navigatorKey,
      child: widget.child,
    );
  }
}
