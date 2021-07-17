import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/config.dart';

import '../app/app_module.dart';

abstract class SigninContract {
  error(String text);
}

class SigninPresenter {
  final SigninContract _contract;
  final AuthUser auth;
  final map = <String, dynamic>{};
  final form = GlobalKey<FormState>();
  SigninPresenter(this._contract, this.auth);
  signInGoogle()async{
    final error = await auth.signinGoogle();
    if(error != null){
      _contract.error(error);
      return;
    }
    Modular.to.pop();
  }
  signInApple()async{
    final error = await auth.signinApple();
    if(error != null){
      _contract.error(error);
      return;
    }
    Modular.to.pop();
  }
  signInFacebook()async{
    final error = await auth.signinFacebook();
    if(error != null){
      _contract.error(error);
      return;
    }
    Modular.to.pop();
  }
  signIn() async {
    if (form.currentState.validate()) {
      final error = await auth.singin(map);
       AppModule.to<Config>().showLog(error != null ? 'Erro recebido $error':'Nenhum erro recebido');
      if (error != null) {
        _contract.error(error);
        return;
      }
      Modular.to.pop();
    }
  }
}
