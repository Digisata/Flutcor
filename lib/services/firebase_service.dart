import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutcor/providers/providers.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailPassword(String email, String password);
  Future<String> signUpWithEmailPassword(String email, String password);
  Future<FirebaseUser> getCurrentUser();
  Future<void> sendEmailVerification();
  Future<void> signOut();
  Future<bool> isEmailVerified();
}

class FirebaseAuths implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();
  final AppProvider _appProvider = AppProvider();

  Future<String> signInWithEmailPassword(String email, String password) async {
    AuthResult _result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser _user = _result.user;
    assert(_user != null);
    return _user.uid;
  }

  Future<String> signUpWithEmailPassword(String email, String password) async {
    AuthResult _result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser _user = _result.user;
    assert(_user != null);
    return _user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser _user = await _firebaseAuth.currentUser();
    return _user;
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      if (!await _googleSignIn.isSignedIn()) {
        await _facebookLogin.logOut();
        _appProvider.isLoggedIn = false;
      } else {
        await _googleSignIn.disconnect();
        _appProvider.isLoggedIn = false;
      }
    } catch (error) {
      throw 'catch error: $error';
    }
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser _user = await _firebaseAuth.currentUser();
    assert(_user != null);
    _user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser _user = await _firebaseAuth.currentUser();
    assert(_user != null);
    return _user.isEmailVerified;
  }
}
