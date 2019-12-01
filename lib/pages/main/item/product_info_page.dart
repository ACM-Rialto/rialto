import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rialto/data/product.dart';

class ProductInformationPage extends StatelessWidget {
  final Product product;

  ProductInformationPage({this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.centerLeft,
        child: ListView(
          children: <Widget>[
            Container(
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
            Text(
              "${product.name}",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Price: \$${product.price}",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                new FlatButton(
                  color: Colors.white,
                  onPressed: () {},
                  child: Text(
                    "Contact",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent),
                  ),
                ),
              ],
            ),
            new Card(
              child: new Container(
                padding: new EdgeInsets.all(32.0),
                child: new Column(
                  children: <Widget>[
                    Text(
                      '${product.description}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
