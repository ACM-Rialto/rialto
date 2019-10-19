import 'package:cloud_firestore/cloud_firestore.dart';
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

  void createRecord(databaseReference) async {
    await databaseReference.collection("items").document().setData({
      'name': _itemName,
      'description': _itemDescription,
      'price': _itemPrice,
      'seller': 'a@utdallas.edu',
    });
  }

  Widget _buildForm(BuildContext context, databaseReference) {
    var pictureUploadWidget = _PictureUpload();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.5),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              pictureUploadWidget,
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
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
                width: MediaQuery.of(context).size.width * 0.8,
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
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onSaved: (value) {
                    _itemDescription = value;
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.attach_money,
                    color: Theme.of(context).primaryColor,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
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
              SizedBox(
                height: 10,
              ),
              Center(
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Upload",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                    }
                    createRecord(databaseReference);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PictureUpload extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PictureUploadState();
  }
}

class _PictureUploadState extends State<_PictureUpload> {
  final List<Image> _images = new List();

  @override
  void initState() {
    super.initState();
  }

  Future getImageFromGallery() async {
    // for gallery
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _images.add(Image.file(image));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (_images.length == 0) {
          getImageFromGallery();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          border: Border.all(),
          color: _images.length == 0
              ? Theme.of(context).primaryColor
              : Colors.white,
        ),
        child: _images.length == 0
            ? Center(
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).accentColor,
                  size: 72,
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _images.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  var child;
                  if (index == _images.length) {
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
                        child: _images[index],
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
