import 'package:flutter/material.dart';
import 'package:rialto/data/product.dart';

class ProductInfo extends StatelessWidget {
  final Product prod;

  ProductInfo({this.prod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("PRODUCT INFORMATION"),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.centerLeft,
        child: ListView(
          children: <Widget>[
            Image.network(
              prod.image,
              height: 250,
              width: 400,
            ),
            Text(
              "${prod.name}",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),
            new Row(
              children: <Widget>[
                Text(
                  "Price: \$${prod.price}",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 125),
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
                      "Description: ${prod.description}",
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
