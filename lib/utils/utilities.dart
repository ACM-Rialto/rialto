import 'package:flutter/material.dart';

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
              Theme.of(context).primaryColor,
            ),
          ),
        ),
      );
    },
  );
}
