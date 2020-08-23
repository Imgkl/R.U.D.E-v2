import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:rude/screens/app/app.dart';
import 'package:rude/screens/auth/auth.dart';
import 'package:rude/screens/onboard/onboarding.dart';
import 'package:rude/services/environment_strings.dart';
import 'package:rude/util/utils.dart';
import 'package:wiredash/wiredash.dart';

void main() async{
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
      child: Wiredash(
        options: WiredashOptionsData(
          showDebugFloatingEntryPoint: false
        ),
        secret: EnvironmentConfig.WIREDASH_SECRET_ID,
        projectId: EnvironmentConfig.WIREDASH_PROJECT_ID,
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
            "/auth": (_) => AuthScreen(),
            "/onboard": (_) => OnBoard(),
          },
        ),
      ),
    );
  }
}
