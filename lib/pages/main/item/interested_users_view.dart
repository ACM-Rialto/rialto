import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rialto/data/rialto_user.dart';
import 'package:rialto/pages/qr/generate_code_page.dart';

class InterestedUsersView extends StatefulWidget {
  final DocumentSnapshot productDocument;
  final RialtoUser sellerUser;

  InterestedUsersView(this.sellerUser, this.productDocument);

  @override
  State<StatefulWidget> createState() {
    return new InterestedUsersViewState();
  }
}

class InterestedUsersViewState extends State<InterestedUsersView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: widget.productDocument.reference.snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        Widget child = new Container();
        if (snapshot.data != null) {
          Map namesForEmail = snapshot.data.data['names_for_email'];
          List names = namesForEmail.values.toList();
          List emails = namesForEmail.keys.toList();
          child = _createNamesList(namesForEmail, names, emails, snapshot);
        }
        return Container(
          height: 500,
          width: 500,
          child: child,
        );
      },
    );
  }

  Widget _createNamesList(Map namesForEmail, List names, List emails,
      AsyncSnapshot<DocumentSnapshot> snapshot) {
    return ListView.separated(
      itemBuilder: (context, index) {
        if (index >= names.length + 1) {
          return null;
        } else if (index == 0) {
          return Text(
            "Interest Users",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        }
        index -= 1;
        return _createNameRow(namesForEmail, names, emails, index, snapshot);
      },
      itemCount: names.length + 1,
        separatorBuilder: (context, index) {
          if (index == 0) {
            return Divider(
            color: Colors.black,
              thickness: 3,
            );
          }
          return Divider(
            color: Colors.black,
          );
        }
    );
  }

  Widget _createNameRow(Map namesForEmail, List names, List emails, int index,
      AsyncSnapshot<DocumentSnapshot> snapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(names[index]),
        Row(
          children: <Widget>[
            _createApproveButton(emails, index),
            _createDismissalButton(namesForEmail, emails, index, snapshot),
          ],
        ),
      ],
    );
  }

  Widget _createApproveButton(List emails, int index) {
    return IconButton(
      icon: Icon(Icons.check),
      color: Theme
          .of(context)
          .primaryColor,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return _createQRDialog(emails, index);
          },
        );
      },
    );
  }

  Widget _createQRDialog(List emails, int index) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: new GeneratedCodeView(
        seller: widget.sellerUser.firebaseUser.email,
        buyer: emails[index],
      ),
    );
  }

  Widget _createDismissalButton(Map namesForEmail, List emails, int index,
      AsyncSnapshot<DocumentSnapshot> snapshot) {
    return IconButton(
      icon: Icon(Icons.remove),
      color: Theme
          .of(context)
          .primaryColor,
      onPressed: () {
        namesForEmail.remove(emails[index]);
        snapshot.data.reference.updateData({
          'names_for_email': namesForEmail,
        });
      },
    );
  }
}
