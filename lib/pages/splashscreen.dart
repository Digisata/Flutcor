import 'package:flutcor/providers/providers.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppProvider _appProvider = AppProvider();

  checkLoginStatus() {
    if (!_appProvider.isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/loginPage');
    } else {
      Navigator.pushReplacementNamed(context, '/homePage');
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
