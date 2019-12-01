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

abstract class FrontPage extends StatefulWidget {
  void showLoadingDialog(BuildContext context, {double width, double height}) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          width: width,
          height: height,
          color: Colors.black54,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                Theme
                    .of(context)
                    .primaryColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
