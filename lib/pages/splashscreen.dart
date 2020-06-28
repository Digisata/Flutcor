import 'package:flutcor/services/services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuths _firebaseAuths = FirebaseAuths();

  checkLoginStatus() async {
    if (await _firebaseAuths.getCurrentUser() == null) {
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
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
