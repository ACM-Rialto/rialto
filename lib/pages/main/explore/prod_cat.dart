import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rialto/data/product.dart';
import 'package:rialto/pages/main/explore/horizontal_list.dart';

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