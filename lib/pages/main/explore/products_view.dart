import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rialto/data/product.dart';
import 'package:rialto/pages/main/item/interested_users_view.dart';
import 'package:rialto/utils/text_utilities.dart';

class ProductsView extends StatefulWidget {
  final Firestore firestore = Firestore.instance;
  final Stream refreshTrigger;

  ProductsView({this.refreshTrigger});

  ProductsViewState createState() => ProductsViewState();
}

class ProductsViewState extends State<ProductsView> {
  final List<Product> _products = new List();
  final Key _scrollKey = new PageStorageKey('scroll-preservation');
  StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();
    refreshProducts();
    streamSubscription = widget.refreshTrigger.listen((_) => refreshProducts());
  }

  @override
  void didUpdateWidget(ProductsView old) {
    super.didUpdateWidget(old);
    // in case the stream instance changed, subscribe to the new one
    if (widget.refreshTrigger != old.refreshTrigger) {
      streamSubscription.cancel();
      streamSubscription =
          widget.refreshTrigger.listen((_) => refreshProducts());
    }
  }

  void refreshProducts() {
    _products.clear();
    CollectionReference itemsReference = widget.firestore.collection('items');
    itemsReference.snapshots().forEach((snapshot) {
      snapshot.documents.forEach((documentSnapshot) {
        _products.add(new Product(
          name: documentSnapshot.data['name'],
          price: double.parse("${documentSnapshot.data['price']}"),
          documentId: documentSnapshot.reference.documentID,
          description: documentSnapshot.data['description'],
          image: documentSnapshot.data['image'],
          sellerEmail: documentSnapshot.data['seller'],
        ));
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: _scrollKey,
      itemCount: _products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery
                .of(context)
                .size
                .height / 1),
      ),
      itemBuilder: (BuildContext context, int index) {
        return _SingleProductView(_products[index]);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();
  }
}

class _SingleProductView extends StatelessWidget {
  final Product _product;

  _SingleProductView(this._product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, top: 10.0, bottom: 8.0),
      child: Card(
        elevation: 6.0,
        child: InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Expanded(
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new CachedNetworkImage(
                        imageUrl: _product.image,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.redAccent)),
                        errorWidget: (context, url, error) =>
                            Image.asset("assets/images/logo.png"),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    getTextWithCap(_product.name, 15),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Center(
                    child: Text(
                      "${NumberFormat.simpleCurrency().format(_product.price)}",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                FlatButton(
                  color: Colors.redAccent,
                  onPressed: () async {
                    DocumentSnapshot snapshot = await Firestore.instance
                        .collection('items')
                        .document(_product.documentId)
                        .get();
                    // todo simplify this with helper class for firestore
                    Map namesForEmail = snapshot.data['names_for_email'];
                    if (_product.sellerEmail == "a@utdallas.edu") {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              content: InterestedUsersView(snapshot),
                            );
                          });
                    } else {
                      namesForEmail['a@utdallas.edu'] = 'Arham Siddiqui';
                      snapshot.reference.updateData({
                        'names_for_email': namesForEmail,
                      });
                      Scaffold.of(context).showSnackBar(
                        new SnackBar(
                          content: new Text(
                              "You have marked this item as interested!"),
                        ),
                      );
                    }
                  },
                  child: Text(
                    _product.sellerEmail == 'a@utdallas.edu'
                        ? "View Interested"
                        : "Interested",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
