import 'package:flutcor/commons/commons.dart';
import 'package:flutcor/models/models.dart';
import 'package:flutcor/providers/providers.dart';
import 'package:flutcor/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final AppWidget _appWidget = AppWidget();

  @override
  Widget build(BuildContext context) {
    DetailModel _argumentData = ModalRoute.of(context).settings.arguments;

    final _titleText = Text(
      _argumentData.combinedKey,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSize.dp24(context),
          ),
    );

    final _updateText = Consumer<AppProvider>(
      builder: (_, AppProvider value, __) {
        return Text(
          'Last Update: ${DateFormat('dd-MM-yyyy').format(value.lastUpdate)}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize: ContentSize.dp20(context),
              ),
        );
      },
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
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
                      tooltip: 'Back to list page',
                      icon: Image.asset(
                        'assets/buttons/back_button.png',
                        height: ContentSize.height(context) * 0.03,
                        width: ContentSize.height(context) * 0.03,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: ContentSize.height(context) * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _titleText,
                    ],
                  ),
                ),
                SizedBox(
                  height: ContentSize.height(context) * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _updateText,
                    ],
                  ),
                ),
                SizedBox(
                  height: ContentSize.height(context) * 0.01,
                ),
                _appWidget.card(context, ColorPalette.green, 'Confirmed',
                    'confirmed_icon.png', true, _argumentData.confirmed),
                _appWidget.card(context, ColorPalette.pink, 'Recovered',
                    'recovered_icon.png', true, _argumentData.recovered),
                _appWidget.card(context, ColorPalette.red, 'Deaths',
                    'death_icon.png', true, _argumentData.deaths),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
