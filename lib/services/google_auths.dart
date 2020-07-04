import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuths {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
      assert(_googleUser != null);
      final GoogleSignInAuthentication _googleAuth =
          await _googleUser.authentication;
      assert(_googleAuth != null);
      final AuthCredential _authCredential = GoogleAuthProvider.getCredential(
        idToken: _googleAuth.idToken,
        accessToken: _googleAuth.accessToken,
      );
      assert(_authCredential != null);

      final FirebaseUser _user =
          (await _firebaseAuth.signInWithCredential(_authCredential)).user;
      assert(_user != null);
      assert(_user.displayName != null);
      assert(_user.photoUrl != null);
      assert(!_user.isAnonymous);
      assert(await _user.getIdToken() != null);
      return _user;
    } catch (error) {
      throw 'catch error: $error';
    }
  }
}
