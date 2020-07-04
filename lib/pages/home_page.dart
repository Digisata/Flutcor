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

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final _appProvider = Provider.of<AppProvider>(context, listen: false);

    final _photoProfile = Consumer<AppProvider>(
      builder: (_, AppProvider value, __) {
        return CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: ContentSize.height(context) * 0.06,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: value.photoUrl,
            progressIndicatorBuilder: (context, url, download) =>
                CircularProgressIndicator(
              value: download.progress,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageBuilder: (context, imageProvider) => Container(
              width: ContentSize.height(context) * 0.12,
              height: ContentSize.height(context) * 0.12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
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
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: Theme.of(context).textTheme.headline1.copyWith(
                fontSize: ContentSize.dp24(context),
              ),
        );
      },
    );

    final _adviceText = Text(
      'Stay at home, and stay safe',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline2.copyWith(
            fontSize: ContentSize.dp20(context),
          ),
    );

    final _descriptionText = Text(
      'World wide',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline4.copyWith(
            fontSize: ContentSize.dp22(context),
          ),
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: _drawerWidget.createDrawer(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
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
                              'assets/buttons/refresh_button.png',
                              height: ContentSize.height(context) * 0.03,
                              width: ContentSize.height(context) * 0.03,
                            ),
                            onPressed: () {
                              _appProvider.checkConnection(context);
                            },
                          ),
                          IconButton(
                            tooltip: 'Show main menu',
                            icon: Image.asset(
                              'assets/buttons/menu_button.png',
                              height: ContentSize.height(context) * 0.03,
                              width: ContentSize.height(context) * 0.03,
                            ),
                            onPressed: () {
                              _openEndDrawer();
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ContentSize.height(context) * 0.02,
                      ),
                      _photoProfile,
                      SizedBox(
                        height: ContentSize.height(context) * 0.02,
                      ),
                      _greetingText,
                      _adviceText,
                      SizedBox(
                        height: ContentSize.height(context) * 0.02,
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
                      _appWidget.card(context, ColorPalette.green, 'Confirmed',
                          'confirmed_icon.png'),
                      _appWidget.card(context, ColorPalette.pink, 'Recovered',
                          'recovered_icon.png'),
                      _appWidget.card(context, ColorPalette.red, 'Deaths',
                          'death_icon.png'),
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
      ),
    );
  }
}
