import 'package:flutter/material.dart';
import 'package:rialto/pages/main/explore/horizontal_list.dart';
import 'package:rialto/pages/main/explore/item_upload_page.dart';
import 'package:rialto/pages/main/explore/products_view.dart';
import 'package:rialto/pages/main/navigation_page.dart';
import 'package:rialto/pages/main/explore/search.dart';


class HomePage extends StatefulWidget implements NavigationPage {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemUploadPage()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        ),
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Rialto'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                showSearch(
                context: context,
                delegate: DataSearch()
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_basket, color: Colors.white),
              onPressed: null,
            ),
          ],
        ),
        body: ListView(
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
              height: 560.0,
              child: ProductsView(),
            )
          ],
        ),
      ),
    );
  }
}
