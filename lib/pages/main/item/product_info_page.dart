import 'package:auto_size_text/auto_size_text.dart';
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
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.5,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.075,
              child: FlatButton(
                child: Text(
                  "Contact",
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .accentColor,
                  ),
                ),
                onPressed: () {},
                color: Colors.grey.shade800,
              ),
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.5,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.075,
              child: FlatButton(
                child: Text(
                  "Mark Interested",
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .accentColor,
                  ),
                ),
                onPressed: () {},
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        alignment: Alignment.centerLeft,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Container(
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
            ),
            AutoSizeText(
              "${product.name}",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
              maxLines: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Price: \$${product.price}",
                style: TextStyle(
                  fontSize: 20,
                  color: Theme
                      .of(context)
                      .primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '${product.description}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
