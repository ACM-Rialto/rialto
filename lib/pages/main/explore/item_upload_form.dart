import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ItemUploadForm extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth databaseReference = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter"),
      ),
      body: Center(
        child: _buildForm(context, databaseReference),
      ),
    );
  }

  void createRecord(databaseReference) async {
    await databaseReference.collection("items").document("1").setData(
        {'name': 'shoes', 'description': 'show size 10, colour black'});

    DocumentReference ref = await databaseReference
        .collection("items")
        .add({'name': 'shoes', 'description': 'show size 10, colour black'});
    print(ref.documentID);
  }

  Widget _buildForm(BuildContext context, databaseReference) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextFormField(
                decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10),
                ),
              ),
              hintText: 'Item Name',
              filled: true,
              fillColor: Theme.of(context).accentColor,
            )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 100,
            child: TextFormField(
                decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10),
                ),
              ),
              hintText: 'Item Description',
              filled: true,
              fillColor: Theme.of(context).accentColor,
            )),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: 100,
            child: TextField(
              decoration: new InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text("Upload"),
              onPressed: () {
                createRecord(databaseReference);
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
