import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rialto/data/rialto_user.dart';
import 'package:rialto/pages/main/explore/explore_page.dart';
import 'package:rialto/pages/main/navigation_page.dart';
import 'package:rialto/pages/review_page/review_model.dart';
import 'package:rialto/viewmodels/review_crud.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewPage extends StatefulWidget {

  // Contact contact;

  // ContactPage({@required this.contact});

  final RialtoUser user;
  final bool isBuyer;
  final Map<String, String> transactionData;

  ReviewPage(this.isBuyer, this.transactionData, this.user, {Key key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();

}

class _ReviewPageState extends State<ReviewPage> {

  final _formKey = GlobalKey<FormState>();
  // final bool isBuyer;
  // final Map<String, String> transactionData;
  double rating = 0.0;
  String review;

  _ReviewPageState();
  // _ReviewPageState(this.isBuyer, this.transactionData);

  Widget _buildSubmitButton(String text, VoidCallback onPressed) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 50,
      child: RaisedButton(
        child: Text(
          text,
          style: TextStyle (
            color: Theme.of(context).accentColor,
            fontSize: 16
          )
        ),
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: onPressed
      )
    );
  }

  Future<void> submitReview() {
    _formKey.currentState.save();
    try {
      // await contactProvider.addContact(Contact(name: _name, to: args.sellerEmail, from: _email, message: _message));
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Sent!"),
        ),
      );
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to send... (${e.code})"),
        ),
      );
    };
  }

  Widget get starRatingWidget {
    final int value = 3;
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          return Icon(
            index < value ? Icons.star : Icons.star_border,
            // color: Theme.of(context).accentColor,
            color: Colors.black,
          );
        }) ?? <Widget>[],
      ),
    );
  }

  // Widget get ratingTextFormWidget {
  //   const double borderRadius = 20.0;
  //   return Container (
  //     width: MediaQuery.of(context).size.width * 0.7,
  //     height: 60,
  //     child: TextFormField (
  //       maxLines: 1,
  //       keyboardType: TextInputType.emailAddress,
  //       autofocus: true,
  //       decoration: new InputDecoration(
  //         border: new OutlineInputBorder(
  //           borderRadius: const BorderRadius.all(
  //             const Radius.circular(borderRadius),
  //           )
  //         ),
  //         hintText: 'test',
  //         filled: true,
  //         fillColor: Theme.of(context).accentColor,
  //       ),
  //       validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
  //       // onSaved: (value) => review = value.trim()
  //     )
  //   );
  // }

  Widget get reviewTextFormWidget {
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
          hintText: 'What are your thoughts on this transaction?',
          filled: true,
          fillColor: Theme.of(context).accentColor,
        ),
        // validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => review = value.trim()
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

    // final ReviewPageArguments args = ModalRoute.of(context).settings.arguments;
    final reviewProvider = Provider.of<ReviewCRUD>(context);
    final isBuyer = widget.isBuyer;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Text(
          'Rate Transaction',
          style: TextStyle(
            color: Theme
                .of(context)
                .accentColor,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column (
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.05)),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.7,
                  child: Column(
                    children: <Widget>[
                      // ratingTextFormWidget,
                      // starRatingWidget,
                      Text(
                        "Give this transaction and user a rating ",
                        // + (this.isBuyer ? "Buyer" : "Seller")
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.height * 0.005)),
                      SmoothStarRating(
                        allowHalfRating: true,
                        onRatingChanged: (v) {
                          this.rating = v;
                          setState(() {});
                        },
                        starCount: 5,
                        rating: rating,
                        size: 40.0,
                        color: Colors.yellow,
                        borderColor: Colors.grey,
                        spacing: 0.0,
                      ),
                      Padding(padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.height * 0.05)),
                      reviewTextFormWidget,
                      Padding(padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.height * 0.02)),
                      _buildSubmitButton("Submit", () async {
                        _formKey.currentState.save();
                        try {
                          await reviewProvider.addReview(isBuyer, Review(itemId: widget.transactionData['item'], rating: rating, review: review, buyer: widget.transactionData['buyer'], seller: widget.transactionData['seller']));
                          // await reviewProvider.addContact(Contact(name: _name, to: args.sellerEmail, from: _email, message: _message));
                          // Scaffold.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text("Done!"),
                          //     // content: Text("Done! Rating = " + this.rating.toString() + " | review = " + this.review),
                          //   ),
                          // );
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          // Navigator.of(context).pop();
                          // Navigator.of(context).push(
                          //   new MaterialPageRoute(
                          //     builder: (context) {
                          //       return NavigationPageViewer(widget.user);
                          //     }
                          //   )
                          // );
                        } catch (e) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Failed to send... (${e.code})"),
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
