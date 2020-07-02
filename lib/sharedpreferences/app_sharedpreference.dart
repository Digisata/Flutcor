import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  void syncUserData(String photoUrl, String username) async {
    final SharedPreferences _sharedPreference =
        await SharedPreferences.getInstance();
    String _photoUrl = _sharedPreference.getString('photoUrl');
    assert(_photoUrl != null);
    String _username = _sharedPreference.getString('username');
    assert(_username != null);
    if (_photoUrl != photoUrl)
      await _sharedPreference.setString('photoUrl', photoUrl);
    if (_username != username)
      await _sharedPreference.setString('username', username);
  }

  Future<List<dynamic>> getLocalData() async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    String _photoUrl = _sharedPreference.getString('photoUrl');
    assert(_photoUrl != null);
    String _username = _sharedPreference.getString('username');
    assert(_username != null);
    return [_photoUrl, _username];
  }
}
