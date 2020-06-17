import 'package:flutter/material.dart';
import 'package:flutcor/services/services.dart';
import 'package:flutcor/repositories/repositories.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  TextStyle textStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  FirebaseAuths _firebaseAuths = FirebaseAuths();
  String _photoUrl = '';
  String _username = '';
  var _cases = 0, _recovered = 0, _deaths = 0;

  void getUserInfo() async {
    _firebaseAuths.getCurrentUser().then(
      (value) {
        setState(
          () {
            _photoUrl = value.photoUrl.toString();
            _username = value.displayName.toString();
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  Widget build(BuildContext context) {
    final _photoProfile = CircleAvatar(
      backgroundImage: NetworkImage(_photoUrl),
      radius: 60.0,
    );

    final _greetingText = Text(
      'Hi, $_username',
      textDirection: TextDirection.ltr,
      style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: Colors.black),
    );

    final _adviceText = Text(
      'Stay at home, and stay safe',
      textDirection: TextDirection.ltr,
      style: TextStyle(
          fontSize: 20.0, fontStyle: FontStyle.normal, color: Colors.grey),
    );

    final _updateText = Text(
      'Update',
      textDirection: TextDirection.ltr,
      style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: Colors.black),
    );

    final _listItem = RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {
        CoronaRepository _coronaRepository = CoronaRepository();
        return _coronaRepository.getToken().then(
          (value) async {
            var _casesData = await _coronaRepository.getData(value, 'cases');
            var _recoveredData =
                await _coronaRepository.getData(value, 'recovered');
            var _deathsData = await _coronaRepository.getData(value, 'deaths');

            setState(
              () {
                _cases = _casesData;
                _recovered = _recoveredData;
                _deaths = _deathsData;
              },
            );
          },
        );
      },
      child: Column(
        children: <Widget>[
          Text('Positif: $_cases'),
          Text('Sembuh: $_recovered'),
          Text('Meninggal: $_deaths'),
        ],
      ),
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        /* appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(icon: Image.asset('images/back_button.png'), onPressed: () {}),
          actions: <Widget>[
            IconButton(icon: Image.asset('images/menu_button.png'), onPressed: () {}),
          ],
        ), */
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 10.0, top: 35.0),
                    child: IconButton(
                        icon: Image.asset(
                          'images/menu_button.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                        onPressed: () {}),
                  )
                ],
              ),
              _photoProfile,
              SizedBox(
                height: 10.0,
              ),
              _greetingText,
              _adviceText,
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: _updateText,
                  ),
                ],
              ),
              _listItem,
            ],
          ),
        ),
      ),
    );
  }
}
