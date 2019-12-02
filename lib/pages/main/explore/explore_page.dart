import 'dart:async';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rialto/data/product.dart';
import 'package:rialto/data/rialto_user.dart';
import 'package:rialto/pages/main/explore/horizontal_list.dart';
import 'package:rialto/pages/main/explore/item_upload_page.dart';
import 'package:rialto/pages/main/explore/products_view.dart';
import 'package:rialto/pages/main/explore/search.dart';
import 'package:rialto/pages/main/navigation_page.dart';

class ExplorePage extends StatefulWidget implements NavigationPage {
  final RialtoUser user;

  ExplorePage(this.user, {Key key}) : super(key: key);

  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin<ExplorePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  final refreshNotifier = new StreamController.broadcast();

  final Widget imageCarousel = Container(
    height: 225.0,
    child: Carousel(
      overlayShadow: false,
      borderRadius: true,
      boxFit: BoxFit.contain,
      autoplay: true,
      dotSize: 5.0,
      indicatorBgPadding: 9.0,
      images: [
        new AssetImage('assets/slider/slider1.jpg'),
        new AssetImage('assets/slider/slider2.jpg'),
        new AssetImage('assets/slider/slider3.jpg'),
        new AssetImage('assets/slider/slider4.jpg'),
        new AssetImage('assets/slider/slider5.jpg'),
      ],
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(microseconds: 1500),
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await PermissionHandler().requestPermissions([
            PermissionGroup.location,
            PermissionGroup.locationAlways,
            PermissionGroup.locationWhenInUse
          ]);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ItemUploadPage(
                    widget.user,
                  ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Theme
              .of(context)
              .accentColor,
        ),
        backgroundColor: Theme
            .of(context)
            .primaryColor,
      ),
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
                delegate: DataSearch(widget.user),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          return setState(() {
            refreshNotifier.sink.add(null);
          });
        },
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            imageCarousel,
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0,
              ),
              child: Text(
                'Popular Categories',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black),
              ),
            ),
            HorizontalList(
              widget.user,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.2,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0,
              ),
              child: Text(
                'Popular Products',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 8.0,
              ),
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.5,
              child: ProductsView(
                widget.user,
                populateProductsFromFirebase: populateProductsFromFirebase,
                refreshable: true,
                refreshTrigger: refreshNotifier.stream,
              ),
            )
          ],
        ),
      ),
    );
  }

  void populateProductsFromFirebase(List<Product> products, State state) {
    products.clear();
    CollectionReference itemsReference = Firestore.instance.collection('items');
    itemsReference.snapshots().forEach((snapshot) {
      snapshot.documents.forEach((documentSnapshot) {
        products.add(new Product(
          name: documentSnapshot.data['name'],
          price: double.parse("${documentSnapshot.data['price']}"),
          documentId: documentSnapshot.reference.documentID,
          description: documentSnapshot.data['description'],
          image: documentSnapshot.data['image'],
          imageCount: documentSnapshot.data['image_count'],
          sellerEmail: documentSnapshot.data['seller'],
          category: documentSnapshot.data['category'],
          location: documentSnapshot.data['location'],
          verified: documentSnapshot.data['verified'],
        ));
      });
      products.shuffle();
      state.setState(() {});
    });
  }

  @override
  void dispose() {
    refreshNotifier.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
