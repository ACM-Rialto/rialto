import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rialto/pages/qr/generate_code_page.dart';

class InterestedUsersView extends StatefulWidget {
  final DocumentSnapshot productDocument;

  InterestedUsersView(this.productDocument);

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
          Map namesForEmail = snapshot.data.data['names_for_email'];
          List names = namesForEmail.values.toList();
          List emails = namesForEmail.keys.toList();
          return Container(
            height: 500,
            width: 500,
            child: ListView.separated(
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
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(names[index]),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.check),
                          color: Theme
                              .of(context)
                              .primaryColor,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: new GeneratedCodeView(
                                    seller: 'a@utdallas.edu',
                                    buyer: 'arham@utdallas.edu',
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
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
                        ),
                      ],
                    ),
                  ],
                );
              },
              itemCount: names.length + 1,
              separatorBuilder: (context, index) =>
                  Divider(
                    color: Colors.black,
                  ),
            ),
          );
        });
  }
}
