import 'package:flutcor/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutcor/pages/pages.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: MyApp(),
    ),
  );
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
        fontFamily: 'Padauk',
      ),
    );
  }
}
