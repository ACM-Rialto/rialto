import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'horizontallist.dart';
import 'products.dart';

class PlaceholderWidget extends StatefulWidget {

  State<StatefulWidget> createState()
  {
    return _PlaceWidget();
  }
  
}
class _PlaceWidget extends State<PlaceholderWidget> {

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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
    );
  }
}
