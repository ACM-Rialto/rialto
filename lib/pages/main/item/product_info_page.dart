import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rialto/data/product.dart';
import 'package:rialto/data/rialto_user.dart';
import 'package:rialto/pages/contact/contact_page.dart';
import 'package:rialto/pages/contact/contact_page_arguments.dart';
import 'package:rialto/pages/main/item/interested_users_view.dart';

class ProductInformationPage extends StatelessWidget {
  final Product product;
  final RialtoUser user;
  final GlobalKey scaffoldKey = new GlobalKey();

  ProductInformationPage(this.user, {this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        actions: <Widget>[
          product.sellerEmail != user.firebaseUser.email
              ? IconButton(
            icon: Icon(Icons.crop_free),
            color: Theme
                .of(context)
                .accentColor,
            onPressed: () async {
              String qrResultRaw = await BarcodeScanner.scan();
              Map result = json.decode(qrResultRaw);
              print(qrResultRaw);
              if (result['buyer'] == user.firebaseUser.email &&
                  result['seller'] == product.sellerEmail &&
                  result['item'] == product.documentId) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "The buyer is the same as the QR code!",
                    ),
                  ),
                );
              } else {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Invalid QR code!",
                    ),
                  ),
                );
              }
            },
          )
              : Container(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.5,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.075,
              child: FlatButton(
                child: Text(
                  "Contact",
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .accentColor,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactPage(),
                      settings: RouteSettings(
                        arguments: ContactPageArguments(
                            product.documentId, product.sellerEmail),
                      ),
                    ),
                  );
                },
                color: Colors.grey.shade800,
              ),
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.5,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.075,
              child: FlatButton(
                child: Text(
                  product.sellerEmail == user.firebaseUser.email
                      ? "View Interested"
                      : "Mark Interested",
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .accentColor,
                  ),
                ),
                onPressed: () {
                  markItemInterested(context);
                },
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        alignment: Alignment.centerLeft,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.5,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: new CachedNetworkImage(
                  imageUrl: product.image,
                  placeholder: (context, url) =>
                      CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.redAccent)),
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/images/logo.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            AutoSizeText(
              "${product.name}",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Price: \$${product.price}",
                style: TextStyle(
                  fontSize: 20,
                  color: Theme
                      .of(context)
                      .primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '${product.description}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future markItemInterested(BuildContext context) async {
    DocumentSnapshot snapshot = await Firestore.instance
        .collection('items')
        .document(product.documentId)
        .get();
    // todo simplify this with helper class for firestore
    Map namesForEmail = snapshot.data['names_for_email'];
    if (product.sellerEmail == user.firebaseUser.email) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: InterestedUsersView(user, snapshot),
            );
          });
    } else {
      namesForEmail[user.firebaseUser.email] = 'Arham Siddiqui';
      snapshot.reference.updateData({
        'names_for_email': namesForEmail,
      });
      ScaffoldState scaffold = scaffoldKey.currentState;
      scaffold.showSnackBar(
        new SnackBar(
          content: new Text("You have marked this item as interested!"),
        ),
      );
    }
  }
}
