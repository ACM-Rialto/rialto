import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rialto/data/rialto_user.dart';
import 'package:rialto/pages/contact/contact_page.dart';
import 'package:rialto/pages/contact/contact_page_arguments.dart';
import 'package:rialto/pages/main/explore/search.dart';
import 'package:rialto/pages/main/navigation_page.dart';

class CartPage extends StatefulWidget implements NavigationPage {
  final RialtoUser user;

  CartPage(this.user);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String _itemId = "item1";
  String _sellerEmail = "test@utdallas.edu";

  // String _sellerEmail = "seller@acmrialto.com";
  // String _sellerEmail = "npd160030@utdallas.edu";

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
                delegate: DataSearch(widget.user),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Contact Seller"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactPage(),
                settings: RouteSettings(
                  arguments: ContactPageArguments(_itemId, _sellerEmail),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
