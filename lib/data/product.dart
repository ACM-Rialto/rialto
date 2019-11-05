import 'package:flutter/material.dart';

class Product {
  String name;
  double price;
  String description = "";
  String image;
  String sellerEmail;

  Product(
      {@required this.name,
      @required this.price,
      this.description,
      @required this.image,
      @required this.sellerEmail});
}
