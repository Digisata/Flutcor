import 'package:flutter/material.dart';
import 'package:flutcor/services/services.dart';

class LoginPage extends StatelessWidget {
  final TextStyle _textStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final GoogleAuths _googleAuth = GoogleAuths();
  final FacebookAuths _facebookAuth = FacebookAuths();

  @override
  Widget build(BuildContext context) {
    final signInWithGoogle = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.grey,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _googleAuth.signInWithGoogle().then(
                (value) => Navigator.pushNamed(context, '/homePage'),
              );
        },
        child: Text(
          'Sign in with google',
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          style: _textStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final signInWithFacebook = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _facebookAuth
              .signInWithFacebook()
              .then((value) => Navigator.pushNamed(context, '/homePage'));
        },
        child: Text(
          'Sign in with facebook',
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          style: _textStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[signInWithGoogle, signInWithFacebook],
        ),
      ),
    );
  }
}
