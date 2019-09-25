import 'package:flutter/material.dart';
import 'package:rialto/front_page.dart';

class LoginPage extends FrontPage {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Hello! This is the login page!"),
    );
  }
}
