import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GeneratedCodeView extends StatelessWidget {
  final String buyer;
  final String seller;
  final Map<String, String> data;

  GeneratedCodeView({@required this.buyer, @required this.seller})
      : data = new Map() {
    data['buyer'] = buyer;
    data['seller'] = seller;
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
