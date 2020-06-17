import 'package:flutcor/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  TextStyle textStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  AppProvider _appProvider = AppProvider();

  @override
  void initState() {
    super.initState();
    _appProvider.getUserInfo();
    _appProvider.getCoronaData();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    final _appProvider = Provider.of<AppProvider>(context);

    final _photoProfile = Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider value, Widget child) {
        return CircleAvatar(
          backgroundImage: NetworkImage(value.getPhotoUrl),
          radius: 60.0,
        );
      },
    );

    final _greetingText = Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider value, Widget child) {
        return Text(
          'Hi, ${value.getUsername}',
          textDirection: TextDirection.ltr,
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              color: Colors.black),
        );
      },
    );

    final _adviceText = Text(
      'Stay at home, and stay safe',
      textDirection: TextDirection.ltr,
      style: TextStyle(
          fontSize: 20.0, fontStyle: FontStyle.normal, color: Colors.grey),
    );

    final _updateText = Text(
      'Update',
      textDirection: TextDirection.ltr,
      style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: Colors.black),
    );

    final _listItem = Column(
      children: <Widget>[
        Consumer<AppProvider>(
          builder: (BuildContext context, AppProvider value, Widget child) {
            return Text('Positif: ${value.getCases}');
          },
        ),
        Consumer<AppProvider>(
          builder: (BuildContext context, AppProvider value, Widget child) {
            return Text('Sembuh: ${value.getRecovered}');
          },
        ),
        Consumer<AppProvider>(
          builder: (BuildContext context, AppProvider value, Widget child) {
            return Text('Meninggal: ${value.getDeaths}');
          },
        ),
      ],
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            _appProvider.getUserInfo();
            _appProvider.getCoronaData();
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 10.0, top: 35.0),
                      child: IconButton(
                          icon: Image.asset(
                            'images/menu_button.png',
                            height: 25.0,
                            width: 25.0,
                          ),
                          onPressed: () {}),
                    ),
                  ],
                ),
                _photoProfile,
                SizedBox(
                  height: 10.0,
                ),
                _greetingText,
                _adviceText,
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: _updateText,
                    ),
                  ],
                ),
                _listItem,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
