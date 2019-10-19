import 'package:flutter/material.dart';

class FrontPageViewer extends StatelessWidget {
  final FrontPage page;

  FrontPageViewer({this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: page,
      ),
    );
  }
}

abstract class FrontPage extends StatefulWidget {}
