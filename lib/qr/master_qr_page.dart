import 'package:flutter/material.dart';

class MasterPage extends StatelessWidget {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text("Generate a code"),
              color: Colors.grey.withOpacity(.5),
              onPressed: () {
                Navigator.of(context).pushNamed('/qr/generate');
              },
            ),
            FlatButton(
              child: Text("Scan a code"),
              color: Colors.grey.withOpacity(.5),
              onPressed: () {
                Navigator.of(context).pushNamed('/qr/scan');
              },
            )
          ],
        ),
      ),
    );
  }
}
