import 'package:flutter/material.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/shared/icons_platform.dart';

class ConnectionFail extends StatefulWidget {
  const ConnectionFail({ Key key }) : super(key: key);

  @override
  _ConnectionFailState createState() => _ConnectionFailState();
}

class _ConnectionFailState extends State<ConnectionFail> {
Size size;

  @override
  void initState() {
    super.initState();
    AppModule.to<Config>().showLog('ConnectionFail iniciado');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }
  @override
  void dispose() {
    super.dispose();
    AppModule.to<Config>().showLog('ConnectionFail destruido');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Icon(IconsPlatform.connection,
              size: size.width * .5,
              color: Colors.deepOrange,
              ),
              Text('Desculpe mas parece que você não está conectado a internet .',
              style: TextStyle(
                fontSize: size.width * .05,
              ),
              ),
              TextButton.icon(onPressed: ()async{
               await AppModule.to<AuthUser>().loadUser();
              },
              icon: Icon(IconsPlatform.reset), label: Text("Tentar novamente",style: TextStyle(
                fontSize: size.width * .05,
              ),))


            ]
          ),
        ),)),
    );
  }
}