import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  String name;
  double price;
  String description = "";
  String image;
  String sellerEmail;
  String documentId;
  String category;
  GeoPoint location;
  bool verified;

  Product({
    @required this.name,
    @required this.price,
    @required this.documentId,
    @required this.description,
    @required this.image,
    @required this.sellerEmail,
    @required this.category,
    @required this.location,
    @required this.verified,
  });
}
