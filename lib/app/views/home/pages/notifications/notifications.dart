import 'package:flutter/material.dart';
import 'package:multidelivery/shared/config.dart';

import '../../../../app_module.dart';

class Notifications extends StatefulWidget {
  const Notifications({ Key key }) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    super.initState();
    AppModule.to<Config>().showLog('Notifications Page iniciada');
  }
  @override
  void dispose() {
    super.dispose();
    AppModule.to<Config>().showLog('Notifications Page destruida');
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}