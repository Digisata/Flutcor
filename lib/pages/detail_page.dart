import 'package:flutcor/commons/commons.dart';
import 'package:flutcor/models/models.dart';
import 'package:flutcor/providers/providers.dart';
import 'package:flutcor/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  final AppWidget _appWidget = AppWidget();
  final ColorPalette _colorPalette = ColorPalette();

  @override
  Widget build(BuildContext context) {
    DetailModel _argumentData = ModalRoute.of(context).settings.arguments;

    final _titleText = Text(
      _argumentData.combinedKey,
      maxLines: 2,
      style: Theme.of(context).textTheme.headline1,
    );

    final _updateText = Consumer<AppProvider>(
      builder: (_, AppProvider value, __) {
        return Text(
          'Last Update: ${DateFormat('dd-MM-yyyy').format(value.lastUpdate)}',
          style: Theme.of(context).textTheme.headline2,
        );
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            16.0,
          ),
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
                    tooltip: 'Back to home page',
                    icon: Image.asset(
                      'images/back_button.png',
                      height: 27.0,
                      width: 27.0,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 5.0,
                ),
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
                height: 5.0,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 5.0,
                ),
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
                height: 5.0,
              ),
              _appWidget.card(context, _colorPalette.green, 'Confirmed',
                  'confirmed_icon.png', true, _argumentData.confirmed),
              _appWidget.card(context, _colorPalette.pink, 'Recovered',
                  'recovered_icon.png', true, _argumentData.recovered),
              _appWidget.card(context, _colorPalette.red, 'Deaths',
                  'death_icon.png', true, _argumentData.deaths),
            ],
          ),
        ),
      ),
    );
  }
}
