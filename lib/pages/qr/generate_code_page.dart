import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rialto/data/rialto_user.dart';
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

    var userQuery = Firestore.instance
          .collection('users')
          // .document(widget.data['seller'])
          .where('email', isEqualTo: widget.data['seller'])
          .where('transaction_started', isEqualTo: true)
          .limit(1);

    // await userQuery.getDocuments().then((data) {
    // userQuery.getDocuments().then((data) {
    //   if (data.documents.length > 0) {
    //     userQuery.snapshots().listen((data) {
    //       data.documentChanges.forEach((change) {
    //         print('documentChanges ${change.document.data}');
    //         // userSc.sink.add(new UserEntity.fromSnapshot(data.documents[0]));
    //       });
    //     });
    //   } else {
    //     print('$this data not found');
    //   }
    // });

    // Firestore.instance
    //     .collection('users')
    //     .document(widget.data['seller'])
    //     // .get().asStream().listen((onValue)).
    //     .snapshots()
    //     .listen((event) {
    //       event.data.forEach((change, value) {
    //         print("change = " + change.toString() + " | value = " + value.toString());
    //       });
    //       // showInSnackBar(event.toString());
    //       print("event data: " + event.data.toString());
    //       Firestore.instance
    //         .collection('users')
    //         .document(widget.data['buyer'])
    //         .get()
    //         .then((onValue) {
    //           Navigator.pop(context);
    //           Navigator.of(context).pushReplacement(
    //             new MaterialPageRoute(
    //               builder: (context) {
    //                 return ReviewPage(false, onValue.data['email']);
    //               }
    //             )
    //           );
    //         });

    //       // Navigator.pop(context);
    //       // Navigator.of(context).pushReplacement(
    //       //   new MaterialPageRoute(
    //       //     builder: (context) {
    //       //       return ReviewPage(RialtoUser(

    //       //       ));
    //       //     },
    //       //   )
    //       // );
    //       // todo show review page for seller, do a pop (as shown above), then pushReplacement
    //       // seller: widget.data['seller']
    //       // buyer: widget.data['buyer']
        // });
  }

  // void showInSnackBar(String value) {
  //   Scaffold.of(context).showSnackBar(new SnackBar(
  //       content: new Text(value)
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Container(
    //     width: 250,
    //     height: 250,
    //     child: Center(
    //       child: QrImage(
    //         data: json.encode(widget.data),
    //         version: QrVersions.auto,
    //         size: 200.0,
    //       ),
    //     ),
    //   ),
    // );
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
