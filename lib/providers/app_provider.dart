import 'package:connectivity/connectivity.dart';
import 'package:flutcor/sharedpreferences/sharedpreferences.dart';
import 'package:flutcor/repositories/repositories.dart';
import 'package:flutcor/services/services.dart';
import 'package:flutcor/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  FirebaseAuths _firebaseAuths = FirebaseAuths();
  CoronaRepository _coronaRepository = CoronaRepository();
  AppSharedPreferences _appSharedPreferences = AppSharedPreferences();
  AppWidget _appWidget = AppWidget();
  String _photoUrl = '', _username = '';
  int _cases = 0, _recovered = 0, _deaths = 0, _numIndicator = 1;
  bool _isOnline = true;
  List<dynamic> _localData = [];

  void checkConnection(BuildContext context,
      [bool isManualRefresh = false]) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      getUserData();
      getCoronaData();
      _isOnline = true;
      if (_numIndicator == 3) {
        if (!isManualRefresh)
          _appWidget.showAlertDialog(
            context,
            'Yeaay!',
            'You are online, hope you enjoy the app,....',
            'images/happy_emot.png',
            'Ok',
          );
      } else {
        _numIndicator++;
      }
    } else {
      setOffline();
      if (_numIndicator == 3) {
        _appWidget.showAlertDialog(
          context,
          'Ooops!',
          'You are offline, the data may not up to date,....',
          'images/confused_emot.png',
          'Understand',
        );
      } else {
        _numIndicator++;
      }
    }
  }

  void getUserData() async {
    _firebaseAuths.getCurrentUser().then(
      (value) async {
        _photoUrl = value.photoUrl.toString();
        _username = value.displayName.toString();
        _appSharedPreferences.syncUserData(_photoUrl, _username);
        notifyListeners();
      },
    );
  }

  void getCoronaData() async {
    _coronaRepository.getToken().then(
      (value) async {
        var _casesData = await _coronaRepository.getData(value, 'cases');
        var _recoveredData =
            await _coronaRepository.getData(value, 'recovered');
        var _deathsData = await _coronaRepository.getData(value, 'deaths');
        _cases = _casesData;
        _recovered = _recoveredData;
        _deaths = _deathsData;
        _appSharedPreferences.syncCoronaData(_cases, _recovered, _deaths);
        notifyListeners();
      },
    );
  }

  void setOffline() async {
    _localData = await _appSharedPreferences.getLocalData();
    _photoUrl = _localData[0];
    _username = _localData[1];
    _cases = _localData[2];
    _recovered = _localData[3];
    _deaths = _localData[4];
    _isOnline = false;
    notifyListeners();
  }

  String get getPhotoUrl => this._photoUrl;

  String get getUsername => this._username;

  int get getCases => this._cases;

  int get getRecovered => this._recovered;

  int get getDeaths => this._deaths;

  bool get isOnline => this._isOnline;
}
