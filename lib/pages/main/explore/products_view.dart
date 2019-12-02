import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rialto/data/product.dart';
import 'package:rialto/data/rialto_user.dart';
import 'package:rialto/pages/main/item/product_info_page.dart';
import 'package:rialto/utils/text_utilities.dart';

class ProductsView extends StatefulWidget {
  final Firestore firestore = Firestore.instance;
  final Stream refreshTrigger;
  final Function(List<Product>, State) populateProductsFromFirebase;
  final bool refreshable;
  final RialtoUser user;

  ProductsView(this.user,
      {@required this.populateProductsFromFirebase,
        @required this.refreshable,
        this.refreshTrigger});

  ProductsViewState createState() => ProductsViewState();
}

class ProductsViewState extends State<ProductsView> {
  final List<Product> _products = new List();
  final Key _scrollKey = new PageStorageKey('scroll-preservation');
  StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();
    refreshProducts();
    if (widget.refreshable) {
      streamSubscription =
          widget.refreshTrigger.listen((_) => refreshProducts());
    }
  }

  @override
  void didUpdateWidget(ProductsView old) {
    super.didUpdateWidget(old);
    // in case the stream instance changed, subscribe to the new one
    if (widget.refreshTrigger != old.refreshTrigger) {
      streamSubscription.cancel();
      streamSubscription =
          widget.refreshTrigger.listen((_) => refreshProducts());
    }
  }

  void refreshProducts() {
    widget.populateProductsFromFirebase(_products, this);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: _scrollKey,
      itemCount: _products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery
                .of(context)
                .size
                .height / 1),
      ),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductInformationPage(
                      widget.user,
                      product: _products[index],
                    ),
              ),
            );
          },
          child: _SingleProductView(
            _products[index],
            isVerified: _products[index].verified,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (streamSubscription != null) {
      streamSubscription.cancel();
    }
  }
}

class _SingleProductView extends StatelessWidget {
  final Product _product;
  final bool isVerified;

  _SingleProductView(this._product, {@required this.isVerified});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, top: 10.0, bottom: 8.0),
      child: Card(
        elevation: 6.0,
        child: Stack(
          children: <Widget>[
            isVerified != null && isVerified
                ? Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.check_circle,
                    color: Theme
                        .of(context)
                        .primaryColor,
                  ),
                  AutoSizeText(
                    " Verified Location",
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
                : Container(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Expanded(
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new CachedNetworkImage(
                        imageUrl: _product.image,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.redAccent)),
                        errorWidget: (context, url, error) =>
                            Image.asset("assets/images/logo.png"),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    getTextWithCap(_product.name, 15),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Center(
                    child: Text(
                      "${NumberFormat.simpleCurrency().format(_product.price)}",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
