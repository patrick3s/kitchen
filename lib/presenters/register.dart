import 'package:flutter/material.dart';
import 'package:multidelivery/controllers/register.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';

abstract class RegisterContract {
  error(String text);
  refresh();
}

class RegisterPresenter {
  final RegisterContract _contract;
  final AuthUser authUser;
  String uf ;
  final map = <String,dynamic>{
    'address':{}
  };
  final form = GlobalKey<FormState>();
  RegisterPresenter(this._contract, this.authUser);

  getUf(String idUf){
    uf = idUf;
    map['address']['uf']=ControllerRegister.getUfById(idUf)["Sigla"];
    map['address']['ufName']=ControllerRegister.getUfById(idUf)["Nome"];
    map['address']['city'] = null;
    _contract.refresh();
  }

  save(){
    if(uf == null){
        _contract.error('Informe seu estado');
        return;
      }
    if(map['address']['city'] == null){
        _contract.error('Informe sua cidade');
        return;
      }
    if(form.currentState.validate()){
      map['email'] = authUser.user.email;
      authUser.register(map);
    }
  }

}