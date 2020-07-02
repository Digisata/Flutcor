import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  void setUserData(String photoUrl, String username) async {
    final SharedPreferences _sharedPreference =
        await SharedPreferences.getInstance();
    assert(photoUrl != null);
    await _sharedPreference.setString('photoUrl', photoUrl);
    assert(username != null);
    await _sharedPreference.setString('username', username);
  }

  Future<List<dynamic>> getLocalData() async {
    final SharedPreferences _sharedPreference =
        await SharedPreferences.getInstance();
    String _photoUrl = _sharedPreference.getString('photoUrl');
    String _username = _sharedPreference.getString('username');
    return [_photoUrl, _username];
  }
}
