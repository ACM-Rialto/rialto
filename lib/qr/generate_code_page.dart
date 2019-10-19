import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, String> test = new Map();
    test['buyer'] = "arham.siddiqui@utdallas.edu";
    test['seller'] = "dummy.user@utdallas.edu";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Rialto - QR Code Demo",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: QrImage(
                data: json.encode(test),
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text("Buyer: ${test['buyer']}"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text("Seller: ${test['seller']}"),
            ),
          ],
        ),
      ),
    );
  }
}
