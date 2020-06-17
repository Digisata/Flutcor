import 'package:flutter/material.dart';
import 'package:flutcor/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => LoginPage(),
        '/homePage': (context) => HomePage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutcor',
      theme: ThemeData(
        primaryColor: Colors.blue[600],
        fontFamily: 'Montserrat',
      ),
    );
  }
}
