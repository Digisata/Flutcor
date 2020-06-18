import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  void syncUserData(String photoUrl, String username) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    String _photoUrl = _sharedPreference.getString('photoUrl');
    String _username = _sharedPreference.getString('username');
    if (_photoUrl == photoUrl)
      await _sharedPreference.setString('photoUrl', photoUrl);
    if (_username == username)
      await _sharedPreference.setString('username', username);
  }

  void syncCoronaData(int cases, int recovered, int deaths) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    int _cases = _sharedPreference.getInt('cases');
    int _recovered = _sharedPreference.getInt('recovered');
    int _deaths = _sharedPreference.getInt('deaths');
    if (_cases == cases) await _sharedPreference.setInt('cases', cases);
    if (_recovered == recovered)
      await _sharedPreference.setInt('recovered', recovered);
    if (_deaths == deaths) await _sharedPreference.setInt('deaths', deaths);
  }

  Future<List<dynamic>> getLocalData() async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    String _photoUrl = _sharedPreference.getString('photoUrl');
    String _username = _sharedPreference.getString('username');
    int _cases = _sharedPreference.getInt('cases');
    int _recovered = _sharedPreference.getInt('recovered');
    int _deaths = _sharedPreference.getInt('deaths');
    return [_photoUrl, _username, _cases, _recovered, _deaths];
  }
}
