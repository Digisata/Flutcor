import 'package:flutcor/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DrawerWidget {
  AppWidget _appWidget = AppWidget();

  Widget createDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(51, 106, 255, 100),
        padding: EdgeInsets.fromLTRB(25.0, 35.0, 25.0, 35.0),
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
                    'images/close_button.png',
                    height: 25.0,
                    width: 25.0,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                createMenuList(context, 'About Us'),
                SizedBox(
                  height: 10.0,
                ),
                createMenuList(context, 'More Apps'),
                SizedBox(
                  height: 10.0,
                ),
                createMenuList(context, 'Contact Us'),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    _appWidget.showAlertDialog(
                      context,
                      'We will miss you!',
                      'Are you sure want to logout?',
                      'images/sad_emot.png',
                      '',
                      true,
                    );
                  },
                  child: createMenuList(context, 'Logout'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Version 1.0.0',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontSize: 15.0),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget createMenuList(BuildContext context, String text) {
    return Text(
      text,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline3.copyWith(fontSize: 35.0),
    );
  }
}
