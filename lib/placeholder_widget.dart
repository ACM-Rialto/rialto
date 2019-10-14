import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            new RawMaterialButton(
                onPressed: () {
                  print('Button 1');
                },
              child: new Icon(
                  Icons.shop,
                  size: 35.0,
              ),
              shape: new CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.redAccent,
              padding: const EdgeInsets.all(15.0),
            ),

            new RawMaterialButton(
              onPressed: () {
                print('Button 2');
              },
              child: new Icon(
                Icons.satellite,
                size: 35.0,
              ),
              shape: new CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.redAccent,
              padding: const EdgeInsets.all(15.0),
            ),

            new RawMaterialButton(
              onPressed: () {
                print('Button 3');
              },
              child: new Icon(
                Icons.shop,
                size: 35.0,
              ),
              shape: new CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.redAccent,
              padding: const EdgeInsets.all(15.0),
            ),

            new RawMaterialButton(
              onPressed: () {
                print('Button 4');
              },
              child: new Icon(
                Icons.shop,
                size: 35.0,
              ),
              shape: new CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.redAccent,
              padding: const EdgeInsets.all(15.0),
            ),

            new RawMaterialButton(
              onPressed: () {
                print('Button 5');
              },
              child: new Icon(
                Icons.shop,
                size: 35.0,
              ),
              shape: new CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.redAccent,
              padding: const EdgeInsets.all(15.0),
            ),
          ],
        ),
      )

    );
  }
}