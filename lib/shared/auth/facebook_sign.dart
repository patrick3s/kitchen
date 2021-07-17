import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
class FacebookResponse {
  final bool error;
  final String errorMsg;
  final User user;

  FacebookResponse({this.error, this.errorMsg, this.user});
}
class FacebookSignInAuth {
  final _facebook = FacebookLogin();
  Future<FacebookResponse> login()async{
    final _result = await _facebook.logIn(customPermissions: ['email']);
    switch(_result.status){
      
      case FacebookLoginStatus.success:
       return _loginWithFacebook(_result);
        break;
      case FacebookLoginStatus.cancel:
        return FacebookResponse(
          error: true,
          errorMsg: 'Cancelado pelo usuario'
        );
        break;
      case FacebookLoginStatus.error:
        return FacebookResponse(
          error: true,
          errorMsg: "Falha ao realizar login"
          );
        break;
      default:
      return FacebookResponse(
        error: true,
        errorMsg: "Error desconehcido, tente novamente mais tarde"
      );
      break;
    }
  }

  Future<FacebookResponse> _loginWithFacebook(FacebookLoginResult result)async{
    AuthCredential credential = FacebookAuthProvider.credential(result.accessToken.token);
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return FacebookResponse(user: userCredential.user);
  }

  singout()async{
    await _facebook.logOut();
  }
}