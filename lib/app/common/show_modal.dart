import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

showModalWidget( Widget child) {
  final context = Modular.navigatorKey.currentState.overlay.context;
  if (Platform.isIOS) {
    showCupertinoModalBottomSheet(
        context: context ,
        builder: (context) => child);
  } else {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              controller: ModalScrollController.of(context),
              child: child,
            ));
  }
}