import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rialto/locator.dart';
import 'package:rialto/pages/front/front_page.dart';
import 'package:rialto/pages/front/login_page.dart';
import 'package:rialto/pages/front/signup_authentication.dart';
import 'package:rialto/pages/front/signup_page.dart';
<<<<<<< HEAD
import 'package:rialto/pages/main/navigation_page.dart';
import 'package:rialto/pages/qr/generate_code_page.dart';
import 'package:rialto/pages/qr/master_qr_page.dart';
import 'package:rialto/pages/review_page/review_page.dart';
import 'package:rialto/viewmodels/contact_crud.dart';
=======
import 'package:rialto/viewmodels/CRUDModel.dart';
>>>>>>> d4043eed8a11fe0cf2ed99eb989a9134b0d09c8c

void main() {
  setupLocator();
  runApp(RialtoApp());
}

class RialtoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider (
      providers: [
        ChangeNotifierProvider(builder: (_) => locator<ContactCRUD>()),
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
<<<<<<< HEAD
          '/cart': (context) => CartPage(),
          '/home': (context) => NavigationPageViewer(),
          '/qr': (context) => MasterQRPage(),
          // '/qr/generate': (context) => GeneratedCodePage(),
          '/contactSeller': (context) => ContactPage(),
          '/review': (context) => ReviewPage(),
=======
>>>>>>> d4043eed8a11fe0cf2ed99eb989a9134b0d09c8c
        },
      )
    );
  }
}
