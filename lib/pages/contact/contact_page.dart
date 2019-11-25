import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rialto/pages/contact/contactModel.dart';
import 'package:rialto/pages/contact/contactPageArguments.dart';
import 'package:rialto/pages/main/navigation_page.dart';
import 'package:rialto/viewmodels/CRUDModel.dart';

class ContactPage extends StatefulWidget {

  Contact contact;

  // ContactPage({@required this.contact});

  ContactPage();

  @override
  _ContactPageState createState() => _ContactPageState();

}

class _ContactPageState extends State<ContactPage> {

  final _formKey = GlobalKey<FormState>();

  String _email;
  String _name;
  String _message;

  Widget _buildSubmitButton(String text, VoidCallback onPressed) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.7,
      height: 50,
      child: RaisedButton(
        child: Text(
          text,
          style: TextStyle(
            color: Theme
                .of(context)
                .accentColor,
            fontSize: 16,
          ),
        ),
        color: Theme
            .of(context)
            .primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: onPressed
      ),
    );
  }

  Widget get emailTextFormWidget {
    const double borderRadius = 20.0;
    return Container (
      width: MediaQuery.of(context).size.width * 0.7,
      height: 60,
      child: TextFormField (
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: true,
        decoration: new InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(borderRadius),
            )
          ),
          hintText: 'Your Email',
          filled: true,
          fillColor: Theme.of(context).accentColor,
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim()
      )
    );
  }

  Widget get messageTextFormWidget {
    const double borderRadius = 20.0;
    return Container (
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.25,
      child: TextFormField (
        maxLines: 10,
        keyboardType: TextInputType.multiline,
        autofocus: true,
        decoration: new InputDecoration(
          // contentPadding: EdgeInsets.only(
            // top: MediaQuery.of(context).size.height * 0.25,
            // left: MediaQuery.of(context).size.width * 0.025
          // ),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(borderRadius),
            ),
          ),
          hintText: 'Message',
          filled: true,
          fillColor: Theme.of(context).accentColor,
        ),
        // validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _message = value.trim()
      )
    );
  }

  // Widget get contactFormWidget {
  //   return
    // child: Column (
    //   children: <Widget>[
    //     TextFormField(
    //       decoration: InputDecoration(
    //         labelText: 'Email'
    //       ),
    //     ),
    //     TextFormField(
    //       decoration: InputDecoration(
    //         labelText: 'Message'
    //       )
    //     )
    //   ]
    // );
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // _isIos = Theme.of(context).platform == TargetPlatform.iOS;

    final ContactPageArguments args = ModalRoute.of(context).settings.arguments;
    final contactProvider = Provider.of<CRUDModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Rialto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.space_bar,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/qr');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.shopping_basket, color: Colors.white),
            onPressed: null,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column (
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.15)),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.7,
                  child: Column(
                    children: <Widget>[
                      emailTextFormWidget,
                      Padding(padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.height * 0.01)),
                      messageTextFormWidget,
                      Padding(padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.height * 0.02)),
                      _buildSubmitButton("Submit", () async {
                        // CupertinoAlertDialog(
                        //   key: _formKey,
                        //   title: Text("hello"),
                        //   content: Text(_formKey.toString()),
                        //   actions: <Widget>[
                        //     CupertinoDialogAction(
                        //       isDefaultAction: true,
                        //       child: Text('Yes')
                        //     ),
                        //     CupertinoDialogAction(
                        //       child: Text('No')
                        //     )
                        //   ],
                        // );
                        _formKey.currentState.save();
                        try {
                          // TODO: change second arg for updateProduct to an actual rand ID

                          // if (widget.contact == null) {
                          //   Scaffold.of(context).showSnackBar(SnackBar(content: Text("widget.contact == null")));
                          //   // CupertinoAlertDialog(title: Text("hello"), content: Text("widget.contact == null"), actions: <Widget>[
                          //   //   CupertinoDialogAction(isDefaultAction: true, child: Text('Yes')),
                          //   //   CupertinoDialogAction(child: Text('No'))
                          //   // ],);
                          // }

                          await contactProvider.addContact(Contact(name: _name, to: args.sellerEmail, from: _email, message: _message));
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Successfully logged in!"),
                            ),
                          );
                          Navigator.of(context).pushReplacementNamed('/home');
                        } catch (e) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Failed to login! (${e.code})"),
                            ),
                          );
                        }
                      }),
                    ],
                  )
                )
              ],
            )
          )
        ),
      )
    );

    // return Center(
    //   child: SingleChildScrollView(
    //     child: Form (
    //       key: _formKey,
    //       child: Column (
    //         children: <Widget>[
    //           Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.15)),
    //           Container(
    //             width: MediaQuery
    //                 .of(context)
    //                 .size
    //                 .width * 0.7,
    //             child: Column(
    //               children: <Widget>[
    //                 emailTextFormWidget,
    //                 Padding(padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.height * 0.01)),
    //                 messageTextFormWidget,
    //                 Padding(padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.height * 0.02)),
    //                 _buildSubmitButton("Submit", () async {
    //                   // CupertinoAlertDialog(
    //                   //   key: _formKey,
    //                   //   title: Text("hello"),
    //                   //   content: Text(_formKey.toString()),
    //                   //   actions: <Widget>[
    //                   //     CupertinoDialogAction(
    //                   //       isDefaultAction: true,
    //                   //       child: Text('Yes')
    //                   //     ),
    //                   //     CupertinoDialogAction(
    //                   //       child: Text('No')
    //                   //     )
    //                   //   ],
    //                   // );
    //                   _formKey.currentState.save();
    //                   try {
    //                     // TODO: change second arg for updateProduct to an actual rand ID

    //                     // if (widget.contact == null) {
    //                     //   Scaffold.of(context).showSnackBar(SnackBar(content: Text("widget.contact == null")));
    //                     //   // CupertinoAlertDialog(title: Text("hello"), content: Text("widget.contact == null"), actions: <Widget>[
    //                     //   //   CupertinoDialogAction(isDefaultAction: true, child: Text('Yes')),
    //                     //   //   CupertinoDialogAction(child: Text('No'))
    //                     //   // ],);
    //                     // }

    //                     await contactProvider.addContact(Contact(name: _name, to: args.sellerEmail, from: _email, message: _message));
    //                     Scaffold.of(context).showSnackBar(
    //                       SnackBar(
    //                         content: Text("Successfully logged in!"),
    //                       ),
    //                     );
    //                     Navigator.of(context).pushReplacementNamed('/home');
    //                   } catch (e) {
    //                     Scaffold.of(context).showSnackBar(
    //                       SnackBar(
    //                         content: Text("Failed to login! (${e.code})"),
    //                       ),
    //                     );
    //                   }
    //                 }),
    //               ],
    //             )
    //           )
    //         ],
    //       )
    //     )
    //   ),
    // );
  }

}
