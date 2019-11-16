import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rialto/pages/qr/generate_code_page.dart';

class InterestedUsersView extends StatelessWidget {
  final Map _namesForEmail;
  final List _names;

  InterestedUsersView(this._namesForEmail)
      : _names = _namesForEmail.values.toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 500,
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (index >= _names.length + 1) {
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
              Text(_names[index]),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.check),
                    color: Theme.of(context).primaryColor,
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
                    color: Theme.of(context).primaryColor,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          );
        },
        itemCount: _names.length + 1,
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
      ),
    );
  }
}
