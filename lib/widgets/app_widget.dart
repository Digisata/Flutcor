import 'package:flutcor/commons/commons.dart';
import 'package:flutcor/helper/helpers.dart';
import 'package:flutcor/providers/providers.dart';
import 'package:flutcor/services/services.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/line_scale_party_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class AppWidget {
  GestureDetector card(
      BuildContext context, Color color, String title, String icon,
      [bool isFromDetailPage = false, int data = 0]) {
    return GestureDetector(
      onTap: () {
        if (!isFromDetailPage) {
          Navigator.pushNamed(context, '/listPage',
              arguments: [title, color, icon]);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
        height: ContentSize.height(context) * 0.14,
        width: ContentSize.width(context),
        child: Card(
          color: color,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.ltr,
                      style: Theme.of(context).textTheme.headline3.copyWith(
                            fontSize: ContentSize.dp18(context),
                          ),
                    ),
                    Consumer<AppProvider>(
                      builder: (_, AppProvider value, __) {
                        int _data = 0;
                        if (!isFromDetailPage) {
                          switch (title) {
                            case 'Confirmed':
                              _data = value.confirmed;
                              break;
                            case 'Recovered':
                              _data = value.recovered;
                              break;
                            case 'Deaths':
                              _data = value.deaths;
                              break;
                          }
                        } else {
                          _data = data;
                        }
                        return value.isLoading
                            ? Loading(
                                indicator: LineScalePartyIndicator(),
                                size: 25.0,
                                color: Colors.white,
                              )
                            : Text(
                                '${NumberHelper.format(_data.toString())}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.ltr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(
                                      fontSize: ContentSize.dp25(context),
                                    ),
                              );
                      },
                    ),
                  ],
                ),
                Image.asset(
                  'assets/icons/$icon',
                  height: ContentSize.height(context) * 0.08,
                  width: ContentSize.height(context) * 0.08,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Widget> showAlertDialog(
      BuildContext context, String title, String message, String image,
      [String textBtn, bool isLogout]) async {
    FirebaseAuths _firebaseAuths = FirebaseAuths();
    bool _isLogout = isLogout ?? false;

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
                      image,
                      height: ContentSize.height(context) * 0.2,
                      width: ContentSize.height(context) * 0.2,
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                fontSize: ContentSize.dp24(context),
                              ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          message,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                fontSize: ContentSize.dp20(context),
                              ),
                        ),
                      ),
                      SizedBox(
                        height: ContentSize.height(context) * 0.02,
                      ),
                      _isLogout
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  color: Color.fromRGBO(154, 155, 159, 100),
                                  padding:
                                      EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 5.0),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'No',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: ContentSize.dp24(context),
                                        ),
                                  ),
                                ),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  color: Color.fromRGBO(51, 106, 255, 100),
                                  padding:
                                      EdgeInsets.fromLTRB(40.0, 5.0, 40.0, 5.0),
                                  onPressed: () {
                                    try {
                                      _firebaseAuths.signOut();
                                      Navigator.pushReplacementNamed(
                                          context, '/loginPage');
                                    } catch (error) {
                                      throw 'sign out error: $error';
                                    }
                                  },
                                  child: Text(
                                    'Yes',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: ContentSize.dp24(context),
                                        ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
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
                                      EdgeInsets.fromLTRB(40.0, 5.0, 40.0, 5.0),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    textBtn,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: ContentSize.dp24(context),
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
