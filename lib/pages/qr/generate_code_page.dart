import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GeneratedCodeView extends StatelessWidget {
  final Map<String, String> data;

  GeneratedCodeView(
      {@required String buyer, @required String seller, @required String itemId})
      : data = new Map() {
    data['buyer'] = buyer;
    data['seller'] = seller;
    data['item'] = itemId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      child: Center(
        child: QrImage(
          data: json.encode(data),
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
