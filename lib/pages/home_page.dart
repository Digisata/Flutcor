import 'package:flutcor/providers/providers.dart';
import 'package:flutcor/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final AppWidget _appWidget = AppWidget();
  final DrawerWidget _drawerWidget = DrawerWidget();

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final _appProvider = Provider.of<AppProvider>(context, listen: false);

    final _photoProfile = Consumer<AppProvider>(
      builder: (_, AppProvider value, __) {
        return CircleAvatar(
          backgroundImage: NetworkImage(
            value.getPhotoUrl,
          ),
          radius: 60.0,
        );
      },
    );

    final _greetingText = Consumer<AppProvider>(
      builder: (_, AppProvider value, __) {
        return Text(
          'Hi, ${value.getUsername}',
          textDirection: TextDirection.ltr,
          style: Theme.of(context).textTheme.headline1,
        );
      },
    );

    final _adviceText = Text(
      'Stay at home, and stay safe',
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline2,
    );

    final _updateText = Text(
      'Update',
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline4,
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: _drawerWidget.createDrawer(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: OfflineBuilder(
              connectivityBuilder: (BuildContext context,
                  ConnectivityResult value, Widget child) {
                _appProvider.checkConnection(context);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          tooltip: 'Refresh main menu',
                          icon: Image.asset(
                            'images/refresh_button.png',
                            height: 27.0,
                            width: 27.0,
                          ),
                          onPressed: () {
                            _appProvider.checkConnection(context);
                          },
                        ),
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
                    _appWidget.createCard(context, [102, 187, 106], 'Positive',
                        'positive_icon.png'),
                    _appWidget.createCard(
                        context, [239, 83, 80], 'Recovered', 'health_icon.png'),
                    _appWidget.createCard(
                        context, [189, 74, 75], 'Death', 'death_icon.png'),
                  ],
                );
              },
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
