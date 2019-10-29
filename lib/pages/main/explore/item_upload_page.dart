import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ItemUploadPage extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();

  String _itemName;
  String _itemDescription;
  double _itemPrice;

  @override
  Widget build(BuildContext context) {
    final Firestore databaseReference = Firestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Item",
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      body: _buildForm(context, databaseReference),
    );
  }

  Future<void> createRecord(Firestore databaseReference,
      _PictureUpload pictures) async {
    DocumentReference document = databaseReference.collection("items")
        .document();
    int pictureIndex = 0;
    pictures.imageFiles.forEach((file) async {
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child(
          'images/${document.documentID}/${file.toString()}-$pictureIndex}');
      StorageUploadTask uploadTask = storageReference.putFile(file);
      await uploadTask.onComplete;
      pictureIndex++;
      await document.setData({
        'name': _itemName,
        'description': _itemDescription,
        'price': _itemPrice,
        'seller': 'a@utdallas.edu',
        'image': await storageReference.getDownloadURL()
      });
    });
  }

  Widget _buildForm(BuildContext context, Firestore databaseReference) {
    var pictureUploadWidget = _PictureUpload();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                pictureUploadWidget,
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10),
                        ),
                      ),
                      hintText: 'Item Name',
                      filled: true,
                      fillColor: Theme
                          .of(context)
                          .accentColor,
                    ),
                    onSaved: (value) {
                      _itemName = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10),
                        ),
                      ),
                      hintText: 'Item Description',
                      filled: true,
                      fillColor: Theme
                          .of(context)
                          .accentColor,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    onSaved: (value) {
                      _itemDescription = value;
                    },
                  ),
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.attach_money,
                        color: Theme
                            .of(context)
                            .primaryColor,
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.2,
                        child: TextFormField(
                          decoration: new InputDecoration(labelText: "Price"),
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            _itemPrice = double.parse(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: RaisedButton(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    child: Text(
                      "Upload",
                      style: TextStyle(
                        color: Theme
                            .of(context)
                            .accentColor,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                      }
                      await createRecord(
                          databaseReference, pictureUploadWidget);
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PictureUpload extends StatefulWidget {
  final List<File> imageFiles = new List();

  @override
  State<StatefulWidget> createState() {
    return _PictureUploadState();
  }
}

class _PictureUploadState extends State<_PictureUpload> {
  @override
  void initState() {
    super.initState();
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      widget.imageFiles.add(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.imageFiles.length == 0) {
          getImageFromGallery();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          border: Border.all(),
          color: widget.imageFiles.length == 0
              ? Theme.of(context).primaryColor
              : Colors.white,
        ),
        child: widget.imageFiles.length == 0
            ? Center(
          child: Icon(
            Icons.add,
            color: Theme.of(context).accentColor,
            size: 72,
          ),
        )
            : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.imageFiles.length + 1,
            itemBuilder: (BuildContext context, int index) {
              var child;
              if (index == widget.imageFiles.length) {
                child = GestureDetector(
                  onTap: getImageFromGallery,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.2,
                        color: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context).accentColor,
                          size: 72,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                child = Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                    child: Image.file(widget.imageFiles[index]),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: child,
              );
            }),
      ),
    );
  }
}
