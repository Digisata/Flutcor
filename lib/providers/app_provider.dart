import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutcor/models/models.dart';
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
  int _cases = 0, _recovered = 0, _deaths = 0;
  bool _isOnline = true;
  List<dynamic> _localData = [];

  void checkConnection(BuildContext context) async {
    var _connectivityResult = await (Connectivity().checkConnectivity());
    if (_connectivityResult == ConnectivityResult.mobile ||
        _connectivityResult == ConnectivityResult.wifi) {
      getUserData();
      getCoronaData();
      _isOnline = true;
    } else {
      setOffline();
      _appWidget.showAlertDialog(
        context,
        'Ooops!',
        'You are offline, the data may not up to date,....',
        'images/confused_emot.png',
        'Understand',
      );
    }
  }

  void getUserData() async {
    try {
      FirebaseUser _user = await _firebaseAuths.getCurrentUser();
      _photoUrl = _user.photoUrl.toString();
      _username = _user.displayName.toString();
      _appSharedPreferences.syncUserData(_photoUrl, _username);
      notifyListeners();
    } catch (error) {
      throw 'get user data error: $error';
    }
  }

  void getCoronaData() async {
    try {
      TokenModel _token = await _coronaRepository.getToken();
      var _casesData = await _coronaRepository.getData(_token, 'cases');
      var _recoveredData = await _coronaRepository.getData(_token, 'recovered');
      var _deathsData = await _coronaRepository.getData(_token, 'deaths');
      _cases = _casesData;
      _recovered = _recoveredData;
      _deaths = _deathsData;
      _appSharedPreferences.syncCoronaData(_cases, _recovered, _deaths);
      notifyListeners();
    } catch (error) {
      throw 'get corona data error: $error';
    }
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

  String get getPhotoUrl => _photoUrl;

  String get getUsername => _username;

  int get getCases => _cases;

  int get getRecovered => _recovered;

  int get getDeaths => _deaths;

  bool get isOnline => _isOnline;
}
