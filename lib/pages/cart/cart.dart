import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rialto/pages/contact/contactModel.dart';
import 'package:rialto/pages/contact/contactPageArguments.dart';
import 'package:rialto/pages/contact/contact_page.dart';
import 'package:rialto/pages/main/navigation_page.dart';
import 'package:rialto/viewmodels/CRUDModel.dart';
// import 'package:rialto/pages/front/front_page.dart';
// import 'package:rialto/pages/front/signup_authentication.dart';

// class signupPage extends FrontPage {
//   signupPage({@required this.auth, this.onSignedIn});

//   final BaseAuth auth;
//   final VoidCallback onSignedIn;

//   @override
//   State<StatefulWidget> createState() => new _signupPageState();
// }

class CartPage extends StatefulWidget implements NavigationPage {

  CartPage();

  @override
  _CartPageState createState() => _CartPageState();

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return null;
  // }

}

class _CartPageState extends State<CartPage> {

  String _itemId = "item1";
  String _sellerEmail = "seller@acmrialto.com";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: RaisedButton(
        child: Text("Contact Seller"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactPage(),
              settings: RouteSettings(arguments: ContactPageArguments(_itemId, _sellerEmail))
            )
          );
        },
      )
    );
  }

}




