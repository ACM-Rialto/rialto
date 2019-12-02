import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rialto/pages/review_page/review_page.dart';

class GeneratedCodeView extends StatefulWidget {
  final Map<String, String> data;

  GeneratedCodeView({@required String buyer,
    @required String seller,
    @required String itemId})
      : data = new Map() {
    data['buyer'] = buyer;
    data['seller'] = seller;
    data['item'] = itemId;
    print(json.encode(data));
  }

  @override
  State<StatefulWidget> createState() {
    return GeneratedCodeViewState();
  }
}

class GeneratedCodeViewState extends State<GeneratedCodeView> {
  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection('users')
        .document(widget.data['seller'])
        .snapshots()
        .listen((event) {
          showInSnackBar(widget.data['seller']);
          // Navigator.pop(context);
          // Navigator.of(context).pushReplacement(
          //   new MaterialPageRoute(
          //     builder: (context) {
          //       // return ReviewPage(widget.data['seller']);
          //     },
          //   )
          // );
          // todo show review page for seller, do a pop (as shown above), then pushReplacement
          // seller: widget.data['seller']
          // buyer: widget.data['buyer']
    });
  }

  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }

  @override
  Widget build(BuildContext context) {
    showInSnackBar("hello");
    return Container(
      width: 250,
      height: 250,
      child: Center(
        child: QrImage(
          data: json.encode(widget.data),
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
