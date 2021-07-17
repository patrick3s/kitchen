import 'package:flutter/material.dart';
import 'package:multidelivery/factory/pop_pup/dialog_action.dart';


abstract class IDialog {
  Widget create(BuildContext context, Widget title, Widget content,
      List<DialogAction> actions);
}
