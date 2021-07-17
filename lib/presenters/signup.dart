
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:multidelivery/controllers/singup.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';


abstract class SignUpContract {
  error(String text);
}

class SingUpPresenter {
  final SignUpContract _contract;
  final ControllerSingUp controller;
  final AuthUser auth;
  final form = GlobalKey<FormState>();
  final safetyTip = [
  'Use letras maiúsculas e minúsculas.',
  'Uma senha com mais de 6 caracteres.',
  'Use números e letras.'
  ];
  final map = <String,dynamic>{};
  SingUpPresenter(this._contract, this.controller,this.auth);

   createAccount() async{
    if(form.currentState.validate()){
      final error = await auth.singup(map);
     
      if(error != null){
        _contract.error(error);
        return;
      }
      Modular.to.pop();
    }
  }
}