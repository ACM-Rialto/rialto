import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

class MasterQRPage extends StatelessWidget {
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
      body: _MasterQRPageBody(),
    );
  }
}

class _MasterQRPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Text(
              "Generate a code",
              style: TextStyle(
                color: Theme
                    .of(context)
                    .accentColor,
              ),
            ),
            color: Theme
                .of(context)
                .primaryColor,
            onPressed: () {
              Navigator.of(context).pushNamed('/qr/generate');
            },
          ),
          FlatButton(
            child: Text(
              "Scan a code",
              style: TextStyle(
                color: Theme
                    .of(context)
                    .accentColor,
              ),
            ),
            color: Theme
                .of(context)
                .primaryColor,
            onPressed: () async {
              String qrResultRaw = await BarcodeScanner.scan();
              Map result = json.decode(qrResultRaw);
              print(qrResultRaw);
              if (result['buyer'] == 'a@utdallas.edu') {
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
          )
        ],
      ),
    );
  }
}
