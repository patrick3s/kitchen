import 'package:flutter/material.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/controllers/home.dart';
import 'package:multidelivery/app/views/home/pages/main/main.dart';
import 'package:multidelivery/app/views/home/pages/notifications/notifications.dart';
import 'package:multidelivery/app/views/home/pages/orders/orders.dart';
import 'package:multidelivery/app/views/home/pages/profile/profile.dart';
import 'package:multidelivery/app/views/home/widgets/bottom_navigator.dart';


import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/shared/home_navigator.dart';


class Home extends StatefulWidget {
  const Home({ Key key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = HomeController(AppModule.to<HomeNavigator>().currentPage);
  TextStyle styleFont = TextStyle();
  Size size;
  @override
  void initState() {
    super.initState();
    AppModule.to<Config>().showLog('Home iniciado');
  }
  @override
  void dispose() {
    AppModule.to<Config>().showLog('Home destruido');
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor: Colors.white,
          body: ValueListenableBuilder(
            valueListenable: controller.currentPage,
            builder: (context, status,child) {
              return Stack(
                children: [
                  IndexedStack(
                    index: controller.currentPage.value,
                    children:[
                      Main(),
                      Orders(),
                      Notifications(),
                      Profile()
                    ],
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: CustomBottomNav(controller: controller,))
                ],
              );
            }
          ),
        );
  }

}