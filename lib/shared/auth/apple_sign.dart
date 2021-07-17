import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthAppleResponse {
  final User user;
  final bool error;
  final String errorMsg;
  AuthAppleResponse({
     this.user,
     this.error,
     this.errorMsg,
  });
}

class AppleSignInAuth {
  
  Future<AuthAppleResponse> login()async{
      if(!  await SignInWithApple.isAvailable()){
        return AuthAppleResponse(
          error: true,
          errorMsg: 'Dispositivo não é elegivel para logar com apple.'
        );
      }
      
       final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

      final oauth = OAuthProvider('apple.com');
      final credential = oauth.credential(
        accessToken: appleCredential.authorizationCode,
        idToken: appleCredential.identityToken
      );
      final userCrendential = await FirebaseAuth.instance.signInWithCredential(credential);
      return AuthAppleResponse(
        user: userCrendential.user
      );
  }
  
}