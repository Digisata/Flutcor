import 'package:flutter/material.dart';
import 'package:flutcor/services/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle _textStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  GoogleAuths _googleAuth = GoogleAuths();
  FacebookAuths _facebookAuth = FacebookAuths();
  @override
  Widget build(BuildContext context) {
    final signInWithGoogle = Material(
      borderRadius: BorderRadius.circular(20),
      borderOnForeground: true,
      child: MaterialButton(
        color: Colors.grey,
        minWidth: 350.0,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _googleAuth.signInWithGoogle().then(
                (value) => Navigator.pushNamed(context, '/home_page'),
              );
        },
        child: 
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/google_logo.png", width: 35.0, height: 35.0,alignment: Alignment.bottomLeft,),
            Text(
              '   Sign in with Google',
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              style: _textStyle.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );

    final signInWithFacebook = Material(
      borderRadius: BorderRadius.circular(20),
      borderOnForeground: true,
      child: MaterialButton(
        color: Colors.blue,
        minWidth: 350.0,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _facebookAuth.signInWithFacebook().then(
                (value) => Navigator.pushNamed(context, '/home_page'),
              );
        },
        child: 
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/facebook_logo.png", width: 35.0, height: 35.0,alignment: Alignment.bottomLeft,),
            Text(
              '   Sign in with Facebook',
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              style: _textStyle.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  child: Image.asset('images/logo.png',
                      height: 200.0, width: 200.0)),
              Text(
                "Flutcor",
                style: TextStyle(
                  fontFamily: "Caviar Dreams",
                  fontSize: 72,
                ),
              ),
              Text(
                "Covid-19 Monitoring App Using Flutter Framework",
                style: TextStyle(
                    fontFamily: "Caviar Dreams",
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 45.0),
              signInWithGoogle,
              SizedBox(height: 15.0),
              signInWithFacebook,
              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
