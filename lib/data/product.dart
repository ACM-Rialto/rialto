import 'package:flutter/material.dart';

class Product {
  String name;
  double price;
  String description = "";
  String image;
  String sellerEmail;
  String documentId;

  Product(
      {@required this.name,
      @required this.price,
        @required this.documentId,
      this.description,
      @required this.image,
      @required this.sellerEmail});
}
