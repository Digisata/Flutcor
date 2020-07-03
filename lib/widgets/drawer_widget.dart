import 'package:flutcor/commons/commons.dart';
import 'package:flutcor/providers/app_provider.dart';
import 'package:flutcor/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerWidget {
  final AppWidget _appWidget = AppWidget();

  Widget createDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(51, 106, 255, 100),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Menu',
                      textDirection: TextDirection.ltr,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontSize: 30.0),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/buttons/close_button.png',
                        height: ContentSize.height(context) * 0.03,
                        width: ContentSize.height(context) * 0.03,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/aboutPage');
                      },
                      child: _createMenuList(context, 'About Us'),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        _appWidget.showAlertDialog(
                          context,
                          'We will miss you!',
                          'Are you sure want to logout?',
                          'assets/emots/sad_emot.png',
                          '',
                          true,
                        );
                      },
                      child: _createMenuList(context, 'Logout'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Consumer<AppProvider>(
                      builder: (_, AppProvider value, __) {
                        return Text(
                          'Version ${value.appVersion}',
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(fontSize: 15.0),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createMenuList(BuildContext context, String text) {
    return Text(
      text,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline3.copyWith(fontSize: 35.0),
    );
  }
}
