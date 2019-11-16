import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rialto/data/product.dart';
import 'package:rialto/pages/main/item/interested_users_view.dart';

class ProductsView extends StatefulWidget {
  final Firestore firestore = Firestore.instance;
  List<Product> products = new List();

  ProductsView({Key key}) : super(key: key);

  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  void initState() {
    super.initState();
    CollectionReference itemsReference = widget.firestore.collection('items');
    itemsReference.snapshots().forEach((snapshot) {
      snapshot.documents.forEach((documentSnapshot) {
        widget.products.add(new Product(
          name: documentSnapshot.data['name'],
          price: documentSnapshot.data['price'],
          documentId: documentSnapshot.reference.documentID,
          description: documentSnapshot.data['description'],
          image: documentSnapshot.data['image'],
          sellerEmail: documentSnapshot.data['seller'],
        ));
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery
                .of(context)
                .size
                .height / 1),
      ),
      itemBuilder: (BuildContext context, int index) {
        return _SingleProductView(widget.products[index]);
      },
    );
  }
}

class _SingleProductView extends StatelessWidget {
  final Product _product;

  _SingleProductView(this._product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, top: 10.0, bottom: 8.0),
      child: Card(
        elevation: 6.0,
        color: Colors.cyanAccent,
        child: Hero(
          tag: _product.name,
          child: Material(
            child: InkWell(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.contain, // otherwise the logo will be tiny
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          Image.network(_product.image, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        _product.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        "\$${_product.price}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    ),
                    FlatButton(
                      color: Colors.redAccent,
                      onPressed: () async {
                        if (_product.sellerEmail == "a@utdallas.edu") {
                          DocumentSnapshot snapshot = await Firestore.instance
                              .collection('items')
                              .document(_product.documentId)
                              .get();
                          // todo simplify this with helper class for firestore
                          Map namesForEmail =
                          snapshot.data['namesForEmail'];
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: InterestedUsersView(namesForEmail),
                                );
                              });
                        } else {
                          Scaffold.of(context).showSnackBar(
                            new SnackBar(
                              content: Text("We have notified the seller"),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Interested",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
//          child: GridTile(
//            footer: Container(
//              color: Colors.white70,
//              child: ListTile(
//                leading: Text(prodName, style:TextStyle(fontWeight: FontWeight.bold),
//                ),
//                title: Text("\$$prodPrice", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
//                ),
//              ),
//            ),
//
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Image.asset(prodImage, fit:BoxFit.cover),
//            ),
//          ),
            ),
          ),
        ),
      ),
    );
  }
}
