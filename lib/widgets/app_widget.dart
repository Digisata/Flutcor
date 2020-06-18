import 'package:flutcor/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget {
  Widget createCard(List<int> color, String title, var data, String icon) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      height: 100,
      child: Card(
        color: Color.fromRGBO(color[0], color[1], color[2], 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Consumer<AppProvider>(
                    builder: (BuildContext context, AppProvider value,
                        Widget child) {
                      return Text(
                        '$data',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 25.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      );
                    },
                  ),
                ],
              ),
              Image.asset(
                'images/$icon',
                height: 60.0,
                width: 60.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
