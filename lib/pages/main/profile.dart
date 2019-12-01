import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rialto/data/product.dart';
import 'package:rialto/data/rialto_user.dart';
import 'package:rialto/pages/main/explore/products_view.dart';
import 'package:rialto/pages/main/explore/search.dart';
import 'package:rialto/pages/main/navigation_page.dart';

class Profile extends StatefulWidget implements NavigationPage {
  final RialtoUser user;

  @override
  Profile(this.user, {Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  String _name = "Unknown";
  double _rating = 0.0;
  int _transactions = 0;

  @override
  void initState() {
    super.initState();
    widget.user.getDocument().then((snap) {
      _name = "${snap.data['first_name']} ${snap.data['last_name']}";
      _rating = double.parse("${snap.data['reputation']}");
      _transactions = snap.data['transactions'];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Text(
          'Rialto',
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
                  widget.user,
                  seller: widget.user.firebaseUser.email,
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Hero(
                      tag: 'assets/profile/blank.jpg',
                      child: Container(
                        height: 125.0,
                        width: 125.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(62.5),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/profile/blank.jpg'),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  '$_name',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 2.0,
                                    ),
                                    Text(
                                      "$_rating",
                                      style: TextStyle(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'The University of Texas at Dallas',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '$_transactions Transactions',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              buildPosts(),
            ],
          )
        ],
      ),
    );
  }

  Widget buildPosts() {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.5,
      child: ProductsView(
        widget.user,
        populateProductsFromFirebase: populateProductsFromFirebase,
        refreshable: false,
      ),
    );
  }

  void populateProductsFromFirebase(List<Product> products,
      State<StatefulWidget> state) {
    products.clear();
    Firestore.instance
        .collection('items')
        .where('seller', isEqualTo: widget.user.firebaseUser.email)
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
        ));
      });
      state.setState(() {});
    });
  }
}
