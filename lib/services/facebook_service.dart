import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookAuths {
  final FacebookLogin _facebookLogin = FacebookLogin();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> signInWithFacebook() async {
    final _facebookLoginResult = await _facebookLogin.logIn(['email']);
    final _token = _facebookLoginResult.accessToken.token;

    switch (_facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Facebook login error");
        // onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Facebook login cancelled by user");
        // onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        final AuthCredential credential =
            FacebookAuthProvider.getCredential(accessToken: _token);
        final FirebaseUser user = (await _firebaseAuth.signInWithCredential(credential)).user;
        print("Facebook Logged in");
        return user;
        break;
    }
  }
}
