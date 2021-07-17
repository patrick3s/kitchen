import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:multidelivery/shared/config.dart';

class FcmResource {
  final _fcm = FirebaseMessaging.instance;
  final Config config;
  FcmResource(this.config) {
    config.showLog('FcmResource iniciado');
    _init();
  }
  _init() async {
    if (Platform.isIOS) {
      NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      config.showLog('User granted permission: ${settings.authorizationStatus}');
    }
   FirebaseMessaging.onMessage.listen((RemoteMessage message) { 
      config.showLog('Chegou uma notficação');
      if(message.notification != null){
        // has notification
        
      }
    });
  }
}
