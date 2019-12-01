import 'package:flutter/material.dart';
import 'package:rialto/data/rialto_user.dart';
import 'package:rialto/pages/main/explore/product_category_page.dart';

class HorizontalList extends StatelessWidget {
  final double height;
  final RialtoUser user;

  const HorizontalList(this.user, {@required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            user,
            imageLocation: 'assets/category/electronics.png',
            imageCaption: 'Tech',
          ),
          Category(
            user,
            imageLocation: 'assets/category/manfashion.png',
            imageCaption: 'Clothes',
          ),
          Category(
            user,
            imageLocation: 'assets/category/shoes.png',
            imageCaption: 'Shoes',
          ),
          Category(
            user,
            imageLocation: 'assets/category/watch.png',
            imageCaption: 'Watches',
          ),
          Category(
            user,
            imageLocation: 'assets/category/jewelry.png',
            imageCaption: 'Jewelry',
          ),
          Category(
            user,
            imageLocation: 'assets/category/sunglasses.png',
            imageCaption: 'Sunglasses',
          ),
          Category(
            user,
            imageLocation: 'assets/category/homeappliances.png',
            imageCaption: 'Home',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;
  final RialtoUser user;

  Category(this.user, {this.imageLocation, this.imageCaption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductCategoryPage(
                    user,
                    category: this.imageCaption,
                  ),
            ),
          );
        },
        child: Container(
          width: 100.0,
          height: 100,
          child: ListTile(
            title: Image.asset(
              imageLocation,
              width: 100.0,
              height: 100.0,
            ),
            subtitle: Container(
              height: 15,
              width: 300,
              alignment: Alignment.center,
              child: Text(
                imageCaption,
                style: TextStyle(color: Colors.black, fontSize: 12.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
