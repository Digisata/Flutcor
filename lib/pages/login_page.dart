import 'package:flutcor/commons/commons.dart';
import 'package:flutcor/services/services.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final FacebookAuths _facebookAuth = FacebookAuths();
  final AnonymousAuths _anonymousAuths = AnonymousAuths();

  @override
  Widget build(BuildContext context) {
    final _signInWithFacebook = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: ColorPalette.facebook,
      child: MaterialButton(
        height: ContentSize.height(context) * 0.07,
        minWidth: ContentSize.width(context),
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          try {
            await _facebookAuth.signInWithFacebook();
            Navigator.pushReplacementNamed(context, '/homePage');
          } catch (error) {
            throw 'facebook sign in error: $error';
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/logos/facebook_logo.png",
              width: ContentSize.height(context) * 0.04,
              height: ContentSize.height(context) * 0.04,
              alignment: Alignment.bottomLeft,
            ),
            SizedBox(
              width: ContentSize.height(context) * 0.01,
            ),
            Text(
              'Sign in with Facebook',
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2.copyWith(
                    color: Colors.white,
                    fontSize: ContentSize.dp18(context),
                  ),
            ),
          ],
        ),
      ),
    );

    final _signInAnonymously = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.black,
      child: MaterialButton(
        height: ContentSize.height(context) * 0.07,
        minWidth: ContentSize.width(context),
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          try {
            await _anonymousAuths.signInAnonymously();
            Navigator.pushReplacementNamed(context, '/homePage');
          } catch (error) {
            throw 'anonymous sign in error: $error';
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/logos/anonymous_logo.png",
              width: ContentSize.height(context) * 0.04,
              height: ContentSize.height(context) * 0.04,
              alignment: Alignment.bottomLeft,
            ),
            SizedBox(
              width: ContentSize.height(context) * 0.03,
            ),
            Text(
              'Sign in anonymously',
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2.copyWith(
                    color: Colors.white,
                    fontSize: ContentSize.dp18(context),
                  ),
            ),
          ],
        ),
      ),
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: ContentSize.height(context),
              width: ContentSize.width(context),
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/logos/logo.png',
                    height: ContentSize.height(context) * 0.25,
                    width: ContentSize.height(context) * 0.25,
                  ),
                  SizedBox(
                    height: ContentSize.height(context) * 0.03,
                  ),
                  Text(
                    "Flutcor",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: ContentSize.dp30(context),
                        ),
                  ),
                  Text(
                    "Covid-19 Monitoring App Using Flutter Framework",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          fontSize: ContentSize.dp20(context),
                        ),
                  ),
                  SizedBox(
                    height: ContentSize.height(context) * 0.03,
                  ),
                  _signInAnonymously,
                  SizedBox(
                    height: ContentSize.height(context) * 0.02,
                  ),
                  _signInWithFacebook,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
