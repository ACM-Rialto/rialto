import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rialto/locator.dart';
import 'package:rialto/pages/contact/contact_page.dart';
import 'package:rialto/pages/front/front_page.dart';
import 'package:rialto/pages/front/login_page.dart';
import 'package:rialto/pages/front/signup_authentication.dart';
import 'package:rialto/pages/front/signup_page.dart';
import 'package:rialto/pages/main/navigation_page.dart';
<<<<<<< HEAD
import 'package:rialto/pages/qr/generate_code_page.dart';
import 'package:rialto/pages/qr/master_qr_page.dart';
import 'package:rialto/viewmodels/CRUDModel.dart';
=======
>>>>>>> 0c1406bdbb759ce00e25bccd3e2aa6b6a16307c7

void main() {
  setupLocator();
  runApp(RialtoApp());
}

class RialtoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MultiProvider (
      providers: [
        ChangeNotifierProvider(builder: (_) => locator<CRUDModel>()),
      ],
      child: MaterialApp(
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
          '/sign-up': (context) => FrontPageViewer(page: signupPage(auth: Auth())),
          '/home': (context) => NavigationPageViewer(),
          '/qr': (context) => MasterQRPage(),
          '/qr/generate': (context) => GenerateCodePage(),
          '/contactSeller': (context) => ContactPage(),
        },
      )
=======
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
        '/sign-up': (context) =>
            FrontPageViewer(page: signupPage(auth: Auth())),
        '/home': (context) => NavigationPageViewer(),
      },
>>>>>>> 0c1406bdbb759ce00e25bccd3e2aa6b6a16307c7
    );
  }
}
