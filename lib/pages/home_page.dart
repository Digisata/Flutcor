import 'package:connectivity/connectivity.dart';
import 'package:flutcor/providers/providers.dart';
import 'package:flutcor/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextStyle textStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  AppWidget _appWidget = AppWidget();
  DrawerWidget _drawerWidget = DrawerWidget();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final _appProvider = Provider.of<AppProvider>(context, listen: false);

    void _checkConnection() async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        _appProvider.getUserData();
        _appProvider.getCoronaData();
      } else {
        _appProvider.setOffline();
        _appWidget.showMyDialog(
          context,
          'Ooops!',
          'You are offline, please check your internet connection,....',
          'Understand',
        );
      }
    }

    final _photoProfile = Consumer<AppProvider>(
      builder: (_, AppProvider value, __) {
        return CircleAvatar(
          backgroundImage: NetworkImage(value.getPhotoUrl),
          radius: 60.0,
        );
      },
    );

    final _greetingText = Consumer<AppProvider>(
      builder: (_, AppProvider value, __) {
        return Text(
          'Hi, ${value.getUsername}',
          textDirection: TextDirection.ltr,
          style: TextStyle(
              fontFamily: 'Padauk',
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
        fontFamily: 'Padauk',
        fontSize: 20.0,
        fontStyle: FontStyle.normal,
        color: Colors.grey,
      ),
    );

    final _updateText = Text(
      'Update',
      textDirection: TextDirection.ltr,
      style: TextStyle(
          fontFamily: 'Padauk',
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: Colors.black),
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: _drawerWidget.createDrawer(context),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async {
                _checkConnection();
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
                        IconButton(
                          tooltip: 'Show main menu',
                          icon: Image.asset(
                            'images/menu_button.png',
                            height: 25.0,
                            width: 25.0,
                          ),
                          onPressed: () {
                            _openEndDrawer();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
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
                          padding: EdgeInsets.only(left: 5.0),
                          child: _updateText,
                        ),
                      ],
                    ),
                    _appWidget.createCard(
                        [102, 187, 106], 'Positive', 'positive_icon.png'),
                    _appWidget.createCard(
                        [239, 83, 80], 'Recovered', 'health_icon.png'),
                    _appWidget
                        .createCard([189, 74, 75], 'Death', 'death_icon.png'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
