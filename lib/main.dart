import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:rialto/cat/horizontallist.dart';
import 'package:rialto/front_page.dart';
import 'package:rialto/login_page.dart';
import 'package:rialto/products/products.dart';
import 'package:rialto/signup_authentication.dart';
import 'package:rialto/signup_page.dart';

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
        '/sign-up': (context) =>
            FrontPageViewer(page: signupPage(auth: Auth(),)),
        '/home': (context) => MyHome(),
      },
    );
  }
}

class MyHome extends StatefulWidget {
  MyHome({Key key}) : super(key: key);

  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Widget imageCarousel = Container(
    height: 225.0,
    child: Carousel(
      overlayShadow: false,
      borderRadius: true,
      boxFit: BoxFit.cover,
      autoplay: true,
      dotSize: 5.0,
      indicatorBgPadding: 9.0,
      images: [
        new AssetImage('assets/slider/slider1.jpg'),
        new AssetImage('assets/slider/slider2.jpg'),
        new AssetImage('assets/slider/slider3.jpg'),
        new AssetImage('assets/slider/slider4.jpg'),
        new AssetImage('assets/slider/slider5.jpg'),
        new AssetImage('assets/slider/slider6.jpg'),
      ],
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(microseconds: 1500),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Marketplace'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.shopping_basket, color: Colors.white),
              onPressed: null,
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            imageCarousel,
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0,
              ),
              child: Text(
                'Popular Categories',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black),
              ),
            ),
            HorizontalList(),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0,
              ),
              child: Text(
                'Popular Products',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 8.0,
              ),
            ),
            Container(
              height: 560.0,
              child: Products(),
            )
          ],
        ),
      ),
    );
  }
}
