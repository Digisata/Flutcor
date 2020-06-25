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
      final AuthCredential _credential = GoogleAuthProvider.getCredential(
        idToken: _googleAuth.idToken,
        accessToken: _googleAuth.accessToken,
      );
      assert(_credential != null);

      final FirebaseUser _user =
          (await _firebaseAuth.signInWithCredential(_credential)).user;
      assert(_user.displayName != null);
      assert(_user.photoUrl != null);
      assert(!_user.isAnonymous);
      return _user;
    } catch (error) {
      print('catch error: $error');
    }
  }
}
