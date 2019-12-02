import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rialto/data/product.dart';
import 'package:rialto/data/rialto_user.dart';
import 'package:rialto/pages/main/explore/products_view.dart';

class DataSearch extends SearchDelegate<String> {
  final Firestore firestore = Firestore.instance;
  final List prods = new List();
  final String category;
  final String seller;
  final RialtoUser user;

  DataSearch(this.user, {this.category, this.seller});

  void initState() {
    CollectionReference itemsReference = firestore.collection('items');
    itemsReference.snapshots().forEach((snapshot) {
      snapshot.documents.forEach((documentSnapshot) {
        prods.add(
          documentSnapshot.data['name'],
        );
      });
    });
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      primaryTextTheme: Typography(platform: TargetPlatform.android).white,
      textTheme: Typography(platform: TargetPlatform.android).white,
    );
  }

  final recentProds = ["Pokemon", "Watch", "Gucci"];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ProductsView(
      user,
      populateProductsFromFirebase: populateProductsFromFirebase,
      refreshable: false,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
      stream: getFirestoreQuery().snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        var suggestionsList;
        if (!snapshot.hasData || query == '') {
          suggestionsList = recentProds;
        } else {
          suggestionsList = snapshot.data.documents
              .map<String>((snapshot) => snapshot.data['name'])
              .toList();
        }
        return ListView.builder(
          itemBuilder: (context, index) =>
              ListTile(
                onTap: () {
                  query = suggestionsList[index];
                  showResults(context);
                },
                leading: Icon(Icons.search),
                title: Text(suggestionsList[index]),
              ),
          itemCount: suggestionsList.length,
        );
      },
    );
  }

  Query getFirestoreQuery() {
    Query q = Firestore.instance
        .collection('items')
        .where('name', isGreaterThanOrEqualTo: query);
    if (category != null) {
      q = q.where('category', isEqualTo: category);
    }
    if (seller != null) {
      q = q.where('seller', isEqualTo: seller);
    }
    return q;
  }

  void populateProductsFromFirebase(List<Product> products, State state) {
    products.clear();
    getFirestoreQuery().snapshots().forEach((snapshot) {
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
