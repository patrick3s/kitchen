
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/factory/pop_pup/dialog_action.dart';
import 'package:multidelivery/factory/pop_pup/dialog_factory.dart';

Future<dynamic> notificationPopup(String title, String subtitle,{Function onTap, String labelButton})async{
  return await DialogFactory.showAlertDialog(
    title: Text(title,
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold
    ),
    ),
    content: Text(subtitle,
    style: TextStyle(
      fontSize: 18
    ),
    ),
    actions: [
      DialogAction(child: Text(labelButton ?? "OK"),
       onPressed: onTap ?? (){
         Modular.to.pop();
       })
    ]

  );
}