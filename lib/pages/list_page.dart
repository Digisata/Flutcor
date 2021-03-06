import 'package:flutcor/commons/commons.dart';
import 'package:flutcor/helper/helpers.dart';
import 'package:flutcor/models/models.dart';
import 'package:flutcor/providers/providers.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController _textEditingController = TextEditingController();
  List<dynamic> _argumentData;
  List<DetailModel> _data = [], _duplicateData = [];
  bool _isStartUp = true, _isFound = true;

  void _searchItem(String keyword) {
    List<DetailModel> _temp = [];
    _temp.addAll(_duplicateData);
    if (keyword.isNotEmpty) {
      List<DetailModel> _search = [];
      bool _atLeastFoundOne = false;
      _temp.forEach(
        (item) {
          if (item.combinedKey.toLowerCase().contains(keyword.toLowerCase())) {
            _atLeastFoundOne = true;
            _search.add(item);
          } else {
            if (_atLeastFoundOne)
              _isFound = _atLeastFoundOne;
            else
              _isFound = _atLeastFoundOne;
          }
        },
      );
      setState(
        () {
          _isFound = _atLeastFoundOne;
          _data.clear();
          _data.addAll(_search);
        },
      );
      return;
    } else {
      setState(
        () {
          _isFound = true;
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

    final _foundText = Padding(
      padding: EdgeInsets.only(left: 5.0),
      child: Text(
        'Found ${_data.length} data',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headline2.copyWith(
              fontSize: ContentSize.dp16(context),
            ),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
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
                          height: ContentSize.height(context) * 0.02,
                        ),
                        _updateText,
                      ],
                    ),
                    Image.asset(
                      'assets/icons/${_argumentData[2]}',
                      width: ContentSize.height(context) * 0.08,
                      height: ContentSize.height(context) * 0.08,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ContentSize.height(context) * 0.01,
              ),
              Container(
                height: ContentSize.height(context) * 0.06,
                width: ContentSize.width(context),
                child: TextField(
                  controller: _textEditingController,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Search your area,....',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    suffixIcon: _textEditingController.text != ''
                        ? IconButton(
                            tooltip: 'Clear search',
                            icon: Icon(
                              Icons.clear,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  _isFound = true;
                                  _textEditingController.text = '';
                                  _data.clear();
                                  _data.addAll(_duplicateData);
                                },
                              );
                            },
                          )
                        : Icon(
                            Icons.clear,
                            color: Colors.transparent,
                          ),
                    fillColor: ColorPalette.grey,
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
                    _searchItem(
                      keyword.trim(),
                    );
                  },
                ),
              ),
              SizedBox(
                height: ContentSize.height(context) * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _foundText,
                ],
              ),
              SizedBox(
                height: ContentSize.height(context) * 0.01,
              ),
              Expanded(
                child: _isFound
                    ? ListView.builder(
                        itemCount: _data.length,
                        itemBuilder: (context, index) {
                          DetailModel _itemData = _data[index];
                          String _area = _itemData.combinedKey;
                          String _sum;
                          switch (_argumentData[0]) {
                            case 'Confirmed':
                              _sum = NumberHelper.format(
                                  _itemData.confirmed.toString());
                              break;
                            case 'Recovered':
                              _sum = NumberHelper.format(
                                  _itemData.recovered.toString());
                              break;
                            case 'Deaths':
                              _sum = NumberHelper.format(
                                  _itemData.deaths.toString());
                              break;
                          }

                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/detailPage',
                                arguments: _data[index],
                              );
                              setState(
                                () {
                                  _textEditingController.text = '';
                                  _data.clear();
                                  _data.addAll(_duplicateData);
                                },
                              );
                            },
                            child: _item(
                              context,
                              '$_area',
                              _sum,
                            ),
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

  Container _item(BuildContext context, String title, String sum) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(bottom: 5.0),
      width: ContentSize.width(context),
      height: ContentSize.height(context) * 0.06,
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: ContentSize.dp16(context),
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontFamily: 'Padauk',
            ),
          ),
          Text(
            sum,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: ContentSize.dp16(context),
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
