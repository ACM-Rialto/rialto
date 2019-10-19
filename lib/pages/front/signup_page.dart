import 'package:flutter/material.dart';
import 'package:rialto/pages/front/front_page.dart';
import 'package:rialto/pages/front/signup_authentication.dart';

class signupPage extends FrontPage {
  signupPage({@required this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _signupPageState();
}

class _signupPageState extends State<signupPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  bool _isIos;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      String userId = "";
      try {
        userId = await widget.auth.signUp(_email, _password);
        widget.auth.sendEmailVerification();
        _showVerifyEmailSentDialog();
        print('Signed up user: $userId');
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return Center(
      child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _showBody(),
              _showCircularProgress(),
            ],
          )),
    );
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content:
          new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showBody() {
    return new Form(
      key: _formKey,
      child: new Column(
        children: <Widget>[
          _showEmailInput(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: _showPasswordInput(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: _showPrimaryButton(),
          ),
          _showSecondaryButton(),
          _showErrorMessage(),
        ],
      ),
    );
  }

  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showEmailInput() {
    const double borderRadius = 10.0;
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.7,
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(borderRadius),
            ),
          ),
          hintText: 'Email',
          filled: true,
          fillColor: Theme
              .of(context)
              .accentColor,
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget _showPasswordInput() {
    const double borderRadius = 10.0;
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.7,
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(borderRadius),
            ),
          ),
          hintText: 'Password',
          filled: true,
          fillColor: Theme
              .of(context)
              .accentColor,
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget _showSecondaryButton() {
    return new FlatButton(
      child: new Text('Have an account? Sign in',
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
      color: Colors.white.withOpacity(0.3),
      onPressed: _goToLogin,
    );
  }

  Widget _showPrimaryButton() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.7,
      height: 50,
      child: RaisedButton(
        child: Text(
          "sign up",
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
        onPressed: _validateAndSubmit,
      ),
    );
  }

  void _goToLogin() {
    Navigator.of(context).pushReplacementNamed('/');
  }
}
