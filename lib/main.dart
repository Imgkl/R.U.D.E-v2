import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rude/screens/app/app.dart';
import 'package:rude/screens/onboard/onboarding.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.alataTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: OnBoard(),
      routes: {
         "/app": (_) => App(),
      },
    );
  }
}
