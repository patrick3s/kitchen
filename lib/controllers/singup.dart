
import 'package:flutter/material.dart';

class ControllerSingUp {
  final formAccess = GlobalKey<FormFieldState<bool>>();
  final formAddress = GlobalKey<FormFieldState<bool>>();
  final formInfo = GlobalKey<FormFieldState<bool>>();
  
  Map checkForms() {
    return _iterableInFormsAndReturnFormInvalid();
  }

  Map _iterableInFormsAndReturnFormInvalid(){
    final forms = [
      _createMapToForm('access', formAccess, 'Complete o formulario da Area de acesso.'),
      _createMapToForm('address', formAddress, 'Complete o formulario de endereço.'),
      _createMapToForm('formInfo', formInfo, 'Complete o formulario de informações.')
    ];
    Map formError;
    for(Map form in forms){
      if(form['form'].currentState.value == false){
        formError = form;
        break;
      }
    }
    return formError;
  }

  _createMapToForm(String formName,GlobalKey form, String errorText){
    
    return {
      'formName':formName,
      'form':form,
      'errorText':errorText
    };
  }
  
}