import 'package:flutcor/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget {
  Widget createCard(List<int> color, String title, String icon) {
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
                        fontFamily: 'Padauk',
                        fontSize: 20.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Consumer<AppProvider>(
                    builder: (_, AppProvider value, __) {
                      int data = 0;
                      switch (title) {
                        case 'Positive':
                          data = value.getCases;
                          break;
                        case 'Recovered':
                          data = value.getRecovered;
                          break;
                        case 'Death':
                          data = value.getDeaths;
                          break;
                        default:
                      }
                      return Text(
                        '$data',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontFamily: 'Padauk',
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

  Future<Widget> showMyDialog(BuildContext context, String title,
      String message, String textButton) async {
    return showDialog<Widget>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    color: Color.fromRGBO(51, 106, 255, 100),
                  ),
                  child: Center(
                    child: Image.asset(
                      'images/positive_icon.png',
                      height: 130.0,
                      width: 130.0,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Text(
                          title,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Padauk',
                            fontSize: 25.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          message,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Padauk',
                            fontSize: 20.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: Color.fromRGBO(51, 106, 255, 100),
                            padding:
                                EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 5.0),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              textButton,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Padauk',
                                fontSize: 25.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
