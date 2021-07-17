import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:multidelivery/factory/pop_pup/dialog_action.dart';
import 'package:multidelivery/factory/pop_pup/idialog.dart';


class AndroidDialog implements IDialog {
  @override
  Widget create(BuildContext context, Widget title, Widget content,
      List<DialogAction> actions) {
    return AlertDialog(
      title: title,
      content: content,
      actions: actions?.map<Widget>((e) {
        return TextButton(onPressed: e.onPressed, child: e.child);
      })?.toList(),
    );
  }
}
