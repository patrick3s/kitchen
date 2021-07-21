import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder,
      navigatorKey: Modular.navigatorKey,
      title: "Kitchen",
      onGenerateRoute: Modular.generateRoute,
      theme: ThemeData(fontFamily: "Inconsolata"),
      debugShowCheckedModeBanner: false,
      

      initialRoute: '/',
    );
  }
}
