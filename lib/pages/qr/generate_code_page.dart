import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rialto/data/rialto_user.dart';
import 'package:rialto/pages/review_page/review_page.dart';

class GeneratedCodeView extends StatefulWidget {
  final Map<String, String> data;
  final RialtoUser user;

  GeneratedCodeView(this.user, {@required String buyer,
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
    return GeneratedCodeViewState(this.user);
  }
}

class GeneratedCodeViewState extends State<GeneratedCodeView> {

  final RialtoUser user;
  GeneratedCodeViewState(this.user);

  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection('users')
        .where('email', isEqualTo: widget.data['seller'])
        .limit(1)
        .snapshots()
        .listen((event) {
      event.documentChanges.forEach(
            (change) {
          if (change.type == DocumentChangeType.modified) {
            Navigator.pop(context);
            Navigator.of(context).pushReplacement(
              new MaterialPageRoute(
                builder: (context) {
                  // return ReviewPage(false, widget.data['email']);
                  return ReviewPage(false, widget.data, user);
                }
              )
            );
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
