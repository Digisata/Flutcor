import 'package:flutcor/models/models.dart';
import 'package:flutcor/sharedpreferences/sharedpreferences.dart';
import 'package:flutcor/repositories/repositories.dart';
import 'package:flutcor/services/services.dart';
import 'package:flutcor/widgets/widgets.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AppProvider with ChangeNotifier {
  final FirebaseAuths _firebaseAuths = FirebaseAuths();
  final CoronaRepository _coronaRepository = CoronaRepository();
  final AppSharedPreferences _appSharedPreferences = AppSharedPreferences();
  final AppWidget _appWidget = AppWidget();
  String _photoUrl = '', _username = '', _appVersion = '';
  int _confirmed = 0, _recovered = 0, _deaths = 0;
  bool _isOnline = false, _isLoading = true;
  DateTime _lastUpdate = DateTime.now();
  List<DetailModel> _detailConfirmed = [],
      _detailRecovered = [],
      _detailDeaths = [];
  List<dynamic> _localData = [];

  void checkConnection(BuildContext context) async {
    final _connectivityResult = await (Connectivity().checkConnectivity());
    if (_connectivityResult == ConnectivityResult.mobile ||
        _connectivityResult == ConnectivityResult.wifi) {
      getUserData();
      getMainData();
      getDetailData();
      getAppInfo();
      _isOnline = true;
      _isLoading = false;
      notifyListeners();
    } else {
      _setOffline();
      _appWidget.showAlertDialog(
        context,
        'Ooops!',
        'You are offline, the data may not up to date,....',
        'assets/emots/confused_emot.png',
        'Understand',
      );
    }
  }

  void getUserData() async {
    try {
      final FirebaseUser _user = await _firebaseAuths.getCurrentUser();
      _photoUrl = _user.photoUrl.toString();
      _username = _user.displayName.toString();
      _appSharedPreferences.setUserData(_photoUrl, _username);
      notifyListeners();
    } catch (error) {
      throw 'get user data error: $error';
    }
  }

  void getMainData() async {
    try {
      final CoronaModel _coronaModel = await _coronaRepository.getMainData();
      _confirmed = _coronaModel.confirmed.value;
      _recovered = _coronaModel.recovered.value;
      _deaths = _coronaModel.deaths.value;
      _lastUpdate = _coronaModel.lastUpdate;
      notifyListeners();
    } catch (error) {
      throw 'get main data error: $error';
    }
  }

  void getDetailData() async {
    try {
      _detailConfirmed = await _coronaRepository
          .getDetailData('https://covid19.mathdro.id/api/confirmed');
      _detailRecovered = await _coronaRepository
          .getDetailData('https://covid19.mathdro.id/api/recovered');
      _detailDeaths = await _coronaRepository
          .getDetailData('https://covid19.mathdro.id/api/deaths');
      notifyListeners();
    } catch (error) {
      throw 'get detail data error: $error';
    }
  }

  void _setOffline() async {
    try {
      _localData = await _appSharedPreferences.getLocalData();
      _photoUrl = _localData[0];
      _username = _localData[1];
      _isOnline = false;
      notifyListeners();
    } catch (error) {
      throw 'set offline error: $error';
    }
  }

  void getAppInfo() async {
    try {
      final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
      _appVersion = _packageInfo.version;
      notifyListeners();
    } catch (error) {
      throw 'get app info error: $error';
    }
  }

  String get photoUrl => _photoUrl;

  String get username => _username;

  String get appVersion => _appVersion;

  int get confirmed => _confirmed;

  int get recovered => _recovered;

  int get deaths => _deaths;

  bool get isOnline => _isOnline;

  bool get isLoading => _isLoading;

  DateTime get lastUpdate => _lastUpdate;

  List<DetailModel> get detailConfirmed => _detailConfirmed;

  List<DetailModel> get detailRecovered => _detailRecovered;

  List<DetailModel> get detailDeaths => _detailDeaths;
}
