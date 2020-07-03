import 'package:flutcor/providers/providers.dart';
import 'package:flutcor/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: MyApp(),
    ),
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashScreen(),
        '/loginPage': (context) => LoginPage(),
        '/homePage': (context) => HomePage(),
        '/listPage': (context) => ListPage(),
        '/detailPage': (context) => DetailPage(),
        '/aboutPage': (context) => AboutPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutcor',
      theme: ThemeData(
        fontFamily: 'Padauk',
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            color: Colors.black,
          ),
          headline2: TextStyle(
            fontSize: 20.0,
            fontStyle: FontStyle.normal,
            color: Colors.grey,
          ),
          headline3: TextStyle(
            fontSize: 20.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headline4: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
