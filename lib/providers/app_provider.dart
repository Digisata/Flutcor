import 'package:flutcor/repositories/repositories.dart';
import 'package:flutcor/services/services.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  FirebaseAuths _firebaseAuths = FirebaseAuths();
  CoronaRepository _coronaRepository = CoronaRepository();
  String _photoUrl = '', _username = '';
  int _cases = 0, _recovered = 0, _deaths = 0;

  void getUserInfo() async {
    _firebaseAuths.getCurrentUser().then(
      (value) {
        _photoUrl = value.photoUrl.toString();
        _username = value.displayName.toString();
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
        notifyListeners();
      },
    );
  }

  String get getPhotoUrl => this._photoUrl;

  String get getUsername => this._username;

  int get getCases => this._cases;

  int get getRecovered => this._recovered;

  int get getDeaths => this._deaths;
}
