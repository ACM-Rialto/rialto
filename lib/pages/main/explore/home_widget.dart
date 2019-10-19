import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:rialto/pages/main/explore/horizontal_list.dart';
import 'package:rialto/pages/main/explore/item_upload_form.dart';
import 'package:rialto/pages/main/explore/products.dart';
import 'package:rialto/pages/main/navigation_page.dart';

class HomePage extends StatefulWidget implements NavigationPage {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemUploadForm()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        ),
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Rialto'),
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
