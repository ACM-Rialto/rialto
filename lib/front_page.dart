import 'package:flutter/material.dart';

class FrontPageViewer extends StatelessWidget {
  final FrontPage page;

  FrontPageViewer({this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: page,
      ),
    );
  }
}

abstract class FrontPage extends StatefulWidget {}
