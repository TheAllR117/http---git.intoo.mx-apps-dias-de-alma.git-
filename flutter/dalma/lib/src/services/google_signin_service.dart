import 'package:dalma/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

class GoogleSignInService {
  static GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);

  static Future<GoogleSignInAccount> signInWithGoogle() async {
    final _prefs = new PreferenciasUsuario();
    // Firebase.initializeApp();
    /*try {
      final GoogleSignInAccount account = await _googleSignIn.signIn();
      print(account);
      return account;
    } catch (e) {
      print('error  en google Singin');
      print(e);
      return null;
    }*/

    try {
      final account = await _googleSignIn.signIn();
      final googleAuth = await account.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final firebaseUser =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print('Signed in as: ' + credential.idToken);
      _prefs.token = credential.idToken;
      return account;
    } catch (e) {
      print('error en google Singin');
      print(e);
      return null;
    }

    /*try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final firebaseUser =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print('Signed in as: ' + firebaseUser.user.displayName);
      return googleUser;
    } catch (e) {
      print('error  en google Singin');
      print(e);
      return null;
    }*/
  }
}
