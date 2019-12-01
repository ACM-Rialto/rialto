import 'package:flutter/material.dart';

class ProductCat extends StatelessWidget {

final String category;

ProductCat({this.category});

  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("$category"),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
          ],),
        )
    );
  }
}