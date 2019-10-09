import 'package:flutter/material.dart';
import 'package:rialto/front_page.dart';
import 'package:rialto/login_page.dart';

void main() => runApp(RialtoApp());

class RialtoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rialto',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: Colors.redAccent,
        accentColor: Colors.white,
        primaryTextTheme: Typography(platform: TargetPlatform.android).black,
        textTheme: Typography(platform: TargetPlatform.android).black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      routes: {
        '/': (context) => FrontPageViewer(page: LoginPage()),
      },
    );
  }
}
