
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:rialto/data/product.dart';


class DataSearch extends SearchDelegate<String>
{
  final Firestore firestore = Firestore.instance;

  final List prods = new List();

  void initState() {
    CollectionReference itemsReference = firestore.collection('items');
    itemsReference.snapshots().forEach((snapshot) {
      snapshot.documents.forEach((documentSnapshot) {
        prods.add(documentSnapshot.data['name'],
        );
      });
    });
  }

  
    final recentProds = [
      "Camera",
      "Thing1",
      "Thing2"
    ];

  @override
  List<Widget> buildActions(BuildContext context) 
  {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
         },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context,null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: Card(
          color: Colors.lightGreen,
          child: Center(
            child:Text(query),
          ),
          ),
          ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
    ? recentProds
    : prods.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context,index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.search),
        title: Text(suggestionList[index]),
        ),
        itemCount: suggestionList.length,
      );   
  }
}