import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rialto/data/product.dart';
import 'package:rialto/data/rialto_user.dart';
import 'package:rialto/pages/main/explore/products_view.dart';
import 'package:rialto/pages/main/explore/search.dart';

class ProductCategoryPage extends StatelessWidget {
  final String category;
  final RialtoUser user;

  ProductCategoryPage(this.user, {this.category});

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      title: Text(
        category,
        style: TextStyle(
          color: Theme
              .of(context)
              .accentColor,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Theme
                .of(context)
                .accentColor,
          ),
          onPressed: () {
            showSearch(
              context: context,
              delegate: DataSearch(
                user,
                category: category,
              ),
            );
          },
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: ProductsView(
          user,
          populateProductsFromFirebase: populateProductsFromFirebase,
          refreshable: false,
        ),
      ),
    );
  }

  void populateProductsFromFirebase(List<Product> products,
      State<StatefulWidget> state) {
    products.clear();
    Firestore.instance
        .collection('items')
        .where('category', isEqualTo: category)
        .snapshots()
        .forEach((snapshot) {
      snapshot.documents.forEach((documentSnapshot) {
        products.add(new Product(
          name: documentSnapshot.data['name'],
          price: double.parse("${documentSnapshot.data['price']}"),
          documentId: documentSnapshot.reference.documentID,
          description: documentSnapshot.data['description'],
          image: documentSnapshot.data['image'],
          sellerEmail: documentSnapshot.data['seller'],
          category: documentSnapshot.data['category'],
          location: documentSnapshot.data['location'],
          verified: documentSnapshot.data['verified'],
        ));
      });
      state.setState(() {});
    });
  }
}
