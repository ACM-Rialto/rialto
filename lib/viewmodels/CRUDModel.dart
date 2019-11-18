import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rialto/pages/contact/contactModel.dart';
import '../locator.dart';
import '../services/api.dart';
// import '../models/productModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  // List<Contact> contacts;


  // Future<List<Contact>> fetchProducts() async {
  //   var result = await _api.getDataCollection();
  //   products = result.documents
  //       .map((doc) => Contact.fromMap(doc.data, doc.documentID))
  //       .toList();
  //   return products;
  // }

  // Stream<QuerySnapshot> fetchProductsAsStream() {
  //   return _api.streamDataCollection();
  // }

  // Future<Contact> getProductById(String id) async {
  //   var doc = await _api.getDocumentById(id);
  //   return  Contact.fromMap(doc.data, doc.documentID) ;
  // }


  Future removeContact(String id) async{
     await _api.removeDocument(id) ;
     return ;
  }

  Future updateContact(Contact data, String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addContact(Contact data) async{
    var result  = await _api.addDocument(data.toJson()) ;
    return ;
  }


}