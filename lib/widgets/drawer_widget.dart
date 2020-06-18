import 'package:flutcor/services/services.dart';
import 'package:flutter/material.dart';

class DrawerWidget {
  FirebaseAuths _firebaseAuths = FirebaseAuths();

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
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      color: Colors.white),
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
            SizedBox(
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                createMenuList('About Us'),
                SizedBox(
                  height: 10.0,
                ),
                createMenuList('More Apps'),
                SizedBox(
                  height: 10.0,
                ),
                createMenuList('Contact Us'),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    _firebaseAuths.signOut().then(
                          (value) => Navigator.pushNamed(context, '/'),
                        );
                  },
                  child: createMenuList('Logout'),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Version 1.0.0',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget createMenuList(String text) {
    return Text(
      text,
      textDirection: TextDirection.ltr,
      style: TextStyle(
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: Colors.white),
    );
  }
}
