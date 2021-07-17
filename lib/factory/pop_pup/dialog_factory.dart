import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/factory/pop_pup/android_dialog.dart';
import 'package:multidelivery/factory/pop_pup/dialog_action.dart';
import 'package:multidelivery/factory/pop_pup/idialog.dart';
import 'package:multidelivery/factory/pop_pup/ios_dialog.dart';


class DialogFactory {
  static GlobalKey<NavigatorState> navigatorKey = Modular.navigatorKey;

  static Future<T> showAlertDialog<T>(
      {Widget title,
      Widget content,
      List<DialogAction> actions,
      bool forceHeight = false}) async {
    IDialog dialogData;
    if (Platform.isIOS) {
      dialogData = IosDialog();
    } else {
      dialogData = AndroidDialog();
    }
    final context = navigatorKey.currentState.overlay.context;
    final size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) => dialogData.create(
            context,
            title ?? Text('Não informado'),
            forceHeight
                ? Container(
                    padding: EdgeInsets.only(top: 20),
                    height: size.height * .4,
                    width: size.width,
                    child: content,
                  )
                : content ?? Text("Não informado"),
            actions ??
                [
                  DialogAction(
                      child: Text('ok'),
                      onPressed: () {
                        Modular.to.pop();
                      })
                ]));
  }
}
