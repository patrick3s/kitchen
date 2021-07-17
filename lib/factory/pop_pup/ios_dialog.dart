import 'package:flutter/cupertino.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:multidelivery/factory/pop_pup/dialog_action.dart';
import 'package:multidelivery/factory/pop_pup/idialog.dart';




class IosDialog implements IDialog {
  @override
  Widget create(BuildContext context, Widget title, Widget content,
      List<DialogAction> actions) {
    return CupertinoAlertDialog(
      title: title,
      content: content,
      actions: actions?.map<Widget>((e) {
        return CupertinoButton(child: e.child, onPressed: e.onPressed);
      })?.toList(),
    );
  }
}
