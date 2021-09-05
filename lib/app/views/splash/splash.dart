import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/app/common/clip_top_splash.dart';
import 'package:multidelivery/app/views/connection/connection.dart';

import 'package:multidelivery/app/views/home/home.dart';
import 'package:multidelivery/app/views/login/login.dart';
import 'package:multidelivery/app/views/register/register.dart';
import 'package:multidelivery/blocs/additional.dart';
import 'package:multidelivery/resources/fcm.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:clip_shadow/clip_shadow.dart';


class Splash extends StatefulWidget {
  const Splash({ Key key }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    AppModule.to<FcmResource>();
    AppModule.to<BlocAdditional>();
    AppModule.to<Config>().showLog('Splash iniciado');
  }
  @override
  void dispose() {
    AppModule.to<Config>().showLog('Splash destruido');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: AppModule.to<AuthUser>().status,
        builder: (context, status, child) {
          if(status == STATUSUSER.LOADING){
            return _splash();
          }
          if(status == STATUSUSER.WITHOUTDATA){
            return Register();
          }
          if(status == STATUSUSER.UNLOGGED){
            return Login();
          }
          if(status == STATUSUSER.CONNECTION){
            return ConnectionFail();
          }
          return Home();
        }
      ),
    );
  }
  _splash(){
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(flex: 1,
                child: ClipShadow(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0,15),
                      blurRadius: 10
                    ),
                  ],
                  clipper: ClipTopSplash(),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Center(
                        child: Container(
                          height: constraints.maxHeight,
                          width: constraints.maxWidth,
                          decoration: ShapeDecoration(
                            color: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(bottom:Radius.circular(20))
                            )),
                          child: Opacity(
                            opacity: .3,
                            child: Image.asset('assets/fundo_logo.png',
                            fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                ),),
                Expanded(flex: 1,
                child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Encontre lanchonetes proximas a você.'),
                    Text('As melhores estão aqui'),
                    
                    Padding(
                      padding: const EdgeInsets.only(top:48.0),
                      child: CircularProgressIndicator(),
                    )
                  ],
                ),),
              ],
            ),
          ),
          Container(),
          Align(
            alignment: Alignment(0,0),
            child: Container(
              height: size.width * .4,
              width: size.width * .4,
              child: Column(
                children: [
                  Expanded(child: Image.asset('assets/logo.png')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Kit',style: TextStyle(
                        fontSize: size.width * .06,
                        color: Colors.deepOrange,
                        
                        fontWeight: FontWeight.bold
                      ),),
                      Text('chen',style: TextStyle(
                        fontSize: size.width * .06,
                        fontWeight: FontWeight.bold
                      ),),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

