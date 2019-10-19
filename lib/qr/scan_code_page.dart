import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScanCodePage extends StatelessWidget {
  // todo when proper flow is established, take in a FirebaseUser from
  // constructor
  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Rialto - QR Code Demo",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
      body: Center(
        child: FlatButton(
          child: Text("Open camera"),
          color: Colors.grey.withOpacity(.5),
          onPressed: () async {
            String qrResultRaw = await BarcodeScanner.scan();
            Map result = json.decode(qrResultRaw);
            if (result['buyer'] == user.email) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "The buyer is the same as the QR code!",
                  ),
                ),
              );
            } else {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Invalid QR code!",
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
