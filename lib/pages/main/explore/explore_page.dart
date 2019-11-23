import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rialto/pages/main/explore/horizontal_list.dart';
import 'package:rialto/pages/main/explore/item_upload_page.dart';
import 'package:rialto/pages/main/explore/products_view.dart';
import 'package:rialto/pages/main/navigation_page.dart';

class ExplorePage extends StatefulWidget implements NavigationPage {
  ExplorePage({Key key}) : super(key: key);

  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  final refreshNotifier = new StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemUploadPage()),
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
            onPressed: null,
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_basket,
              color: Theme
                  .of(context)
                  .accentColor,
            ),
            onPressed: null,
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
            HorizontalList(),
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
                refreshTrigger: refreshNotifier.stream,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    refreshNotifier.close();
    super.dispose();
  }
}
