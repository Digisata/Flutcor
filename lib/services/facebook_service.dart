import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutcor/providers/providers.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookAuths {
  final FacebookLogin _facebookLogin = FacebookLogin();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AppProvider _appProvider = AppProvider();

  signInWithFacebook() async {
    final _facebookLoginResult = await _facebookLogin.logIn(['email']);
    assert(_facebookLoginResult != null);
    final _accessToken = _facebookLoginResult.accessToken.token;
    assert(_accessToken != null);

    switch (_facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        throw "Facebook login error";
        // onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        throw "Facebook login cancelled by user";
        // onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        final AuthCredential _credential = FacebookAuthProvider.getCredential(
          accessToken: _accessToken,
        );
        final FirebaseUser _user =
            (await _firebaseAuth.signInWithCredential(_credential)).user;
        assert(_user.displayName != null);
        assert(_user.photoUrl != null);
        assert(!_user.isAnonymous);
        _appProvider.isLoggedIn = true;
        return _user;
        break;
    }
  }
}
