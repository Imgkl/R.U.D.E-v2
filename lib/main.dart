import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:rude/common_widgets/wiredash_wrapper.dart';
import 'package:rude/screens/app/app.dart';
import 'package:rude/screens/app/settings/settings.dart';
import 'package:rude/screens/auth/auth.dart';
import 'package:rude/screens/onboard/onboarding.dart';
import 'package:rude/util/utils.dart';

void main() async {
  await Util.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return LitAuthInit(
      authProviders: AuthProviders(
        emailAndPassword: true,
        google: true,
        apple: true,
        twitter: true,
      ),
      child: WireDashWrapper(
        navigatorKey: _navigatorKey,
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.alataTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          home: LitAuthState(
            authenticated: App(),
            unauthenticated: OnBoard(),
          ),
          routes: {
            "/app": (_) => App(),
            "/settings": (_) => Settings(),
            "/auth": (_) => AuthScreen(),
            "/onboard": (_) => OnBoard(),
          },
        ),
      ),
    );
  }
}
