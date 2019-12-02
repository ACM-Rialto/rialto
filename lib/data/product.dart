import 'package:flutter/material.dart';

class Product {
  String name;
  double price;
  String description = "";
  String image;
  String sellerEmail;
  String documentId;
  String category;
  int imageCount;

  Product(
      {@required this.name,
      @required this.price,
        @required this.documentId,
      this.description,
      @required this.image,
        @required this.imageCount,
      @required this.sellerEmail,
        @required this.category});
}
