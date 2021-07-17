import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignAuth {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount _user;
  GoogleSignInAccount get user => _user;

  Future<User> login()async{
    final googleUser = await googleSignIn.signIn();
    if(googleUser == null) return null;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    final userCrendential = await FirebaseAuth.instance.signInWithCredential(credential);
    return userCrendential.user;
  }

  signout()async{
    await googleSignIn.signOut();
  }
}