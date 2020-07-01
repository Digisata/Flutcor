import 'package:flutcor/commons/commons.dart';
import 'package:flutcor/helper/helpers.dart';
import 'package:flutcor/models/models.dart';
import 'package:flutcor/providers/providers.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _textEditingController = TextEditingController();
  List<dynamic> _argumentData;
  final NumberHelper _numberHelper = NumberHelper();
  final ColorPalette _colorPalette = ColorPalette();
  List<DetailModel> _data = [], _duplicateData = [];
  bool _isStartUp = true, _isFound = true;

  void searchItem(String keyword) {
    List<DetailModel> _temp = [];
    _temp.addAll(_duplicateData);
    if (keyword.isNotEmpty) {
      List<DetailModel> _search = [];
      bool _atLeastFoundOne = false;
      _temp.forEach(
        (item) {
          if (item.countryRegion
                  .toLowerCase()
                  .contains(keyword.toLowerCase()) ||
              item.provinceState
                  .toLowerCase()
                  .contains(keyword.toLowerCase())) {
            _atLeastFoundOne = true;
            _search.add(item);
          } else {
            if (_atLeastFoundOne)
              _isFound = true;
            else
              _isFound = false;
          }
        },
      );
      setState(
        () {
          _data.clear();
          _data.addAll(_search);
        },
      );
      return;
    } else {
      setState(
        () {
          _data.clear();
          _data.addAll(_duplicateData);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider _appProvider = Provider.of<AppProvider>(context);
    _argumentData = ModalRoute.of(context).settings.arguments;

    if (_isStartUp) {
      switch (_argumentData[0]) {
        case 'Confirmed':
          _data.addAll(_appProvider.detailConfirmed);
          break;
        case 'Recovered':
          _data.addAll(_appProvider.detailRecovered);
          break;
        case 'Deaths':
          _data.addAll(_appProvider.detailDeaths);
          break;
      }
      _duplicateData.addAll(_data);
      _isStartUp = false;
    }

    final _titleText = Text(
      _argumentData[0],
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
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _titleText,
                        SizedBox(
                          height: 10.0,
                        ),
                        _updateText,
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50.0,
                child: TextField(
                  controller: _textEditingController,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Search your area,....',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    fillColor: _colorPalette.grey,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (String keyword) {
                    searchItem(keyword);
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: _isFound
                    ? ListView.builder(
                        itemCount: _data.length,
                        itemBuilder: (context, index) {
                          DetailModel _itemData = _data[index];
                          List<String> _provinceState =
                              _itemData.provinceState.split(' ');
                          String _sum;
                          switch (_argumentData[0]) {
                            case 'Confirmed':
                              _sum = _numberHelper
                                  .format(_itemData.confirmed.toString());
                              break;
                            case 'Recovered':
                              _sum = _numberHelper
                                  .format(_itemData.recovered.toString());
                              break;
                            case 'Deaths':
                              _sum = _numberHelper
                                  .format(_itemData.deaths.toString());
                              break;
                          }

                          return item(
                            context,
                            '${_provinceState[0]}${_provinceState[0] == '' ? '' : ', '}${_itemData.countryRegion}',
                            _sum,
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'Data not found',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget item(BuildContext context, String title, String sum) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(bottom: 5.0),
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: _argumentData[1],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontFamily: 'Padauk',
            ),
          ),
          Text(
            sum,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontFamily: 'Padauk',
            ),
          ),
        ],
      ),
    );
  }
}
