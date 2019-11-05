import 'package:flutter/material.dart';
//import 'profile.dart';

class Products extends StatefulWidget {
  Products({Key key}) : super(key: key);

  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var productList = [
    {"name": "Camera", "image": "assets/products/camera1.jpg", "price": "10"},
    {
      "name": "Home",
      "image": "assets/products/homeappliance1.jpg",
      "price": "50"
    },
    {"name": "Sun Glass", "image": "assets/products/glass1.jpg", "price": "8"},
    {
      "name": "Men's Fashion",
      "image": "assets/products/man1.jpg",
      "price": "10"
    },
    {
      "name": "Necklace",
      "image": "assets/products/jewellery1.jpg",
      "price": "16"
    },
    {"name": "Mobile", "image": "assets/products/mobile1.jpg", "price": "40"},
    {"name": "Shoe", "image": "assets/products/shoe1.jpg", "price": "28"},
    {"name": "Camera", "image": "assets/products/camera1.jpg", "price": "10"},
    {
      "name": "Home",
      "image": "assets/products/homeappliance1.jpg",
      "price": "50"
    },
    {"name": "Sun Glass", "image": "assets/products/glass1.jpg", "price": "8"},
    {
      "name": "Men's Fashion",
      "image": "assets/products/man1.jpg",
      "price": "10"
    },
    {
      "name": "Necklace",
      "image": "assets/products/jewellery1.jpg",
      "price": "16"
    },
    {"name": "Mobile", "image": "assets/products/mobile1.jpg", "price": "40"},
    {"name": "Shoe", "image": "assets/products/shoe1.jpg", "price": "28"}
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: productList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery
                .of(context)
                .size
                .height / 1),
      ),
      itemBuilder: (BuildContext context, int index) {
        return SingleProduct(
          prodName: productList[index]['name'],
          prodPrice: productList[index]['price'],
          prodImage: productList[index]['image'],
        );
      },
    );
  }
}

class SingleProduct extends StatelessWidget {
  final prodName;
  final prodImage;
  final prodPrice;

  SingleProduct({this.prodName, this.prodImage, this.prodPrice});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, top: 10.0, bottom: 8.0),
      child: Card(
        elevation: 6.0,
        color: Colors.cyanAccent,
        child: Hero(
          tag: prodName,
          child: Material(
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new SecondRoute(data: SingleProduct(prodImage: this.prodImage,prodName: this.prodName,prodPrice: this.prodPrice))),
                  );
                },
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
                          child: Image.asset(prodImage, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        prodName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        "\$$prodPrice",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    ),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}

class SecondRoute extends SingleProduct {
  final SingleProduct data;

  SecondRoute({Key key, @required this.data}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More Information"),
      ),
      body: new Container(
        child: new ListView(
          children: <Widget>[
            new Text(data.prodName), 
          ],),
        )
    );
  }
}

