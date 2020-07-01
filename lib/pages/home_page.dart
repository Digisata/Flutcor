import 'package:flutcor/commons/commons.dart';
import 'package:flutcor/providers/providers.dart';
import 'package:flutcor/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AppWidget _appWidget = AppWidget();
  final DrawerWidget _drawerWidget = DrawerWidget();
  final ColorPalette _colorPalette = ColorPalette();

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final _appProvider = Provider.of<AppProvider>(context, listen: false);

    final _photoProfile = Consumer<AppProvider>(
      builder: (_, AppProvider value, __) {
        return CircleAvatar(
          radius: 50.0,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: value.photoUrl,
            progressIndicatorBuilder: (context, url, download) =>
                CircularProgressIndicator(
              value: download.progress,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageBuilder: (context, imageProvider) => Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );

    final _greetingText = Consumer<AppProvider>(
      builder: (_, AppProvider value, __) {
        return Text(
          'Hi, ${value.username}',
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

    final _descriptionText = Text(
      'World wide',
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
                          tooltip: 'Refresh home page',
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
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          child: _descriptionText,
                        ),
                      ],
                    ),
                    _appWidget.card(context, _colorPalette.green, 'Confirmed',
                        'confirmed_icon.png'),
                    _appWidget.card(context, _colorPalette.pink, 'Recovered',
                        'recovered_icon.png'),
                    _appWidget.card(
                        context, _colorPalette.red, 'Deaths', 'death_icon.png')
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
