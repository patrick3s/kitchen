import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/app/common/clip_top_splash.dart';

import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/shared/pallete_colors.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    AppModule.to<Config>().showLog('Login iniciado');
  }
  @override
  void dispose() {
    AppModule.to<Config>().showLog('Login destruido');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Scaffold(
        body: Stack(
      children: [
        Container(
          height: size.height,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: ClipShadow(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 15),
                        blurRadius: 10),
                  ],
                  clipper: ClipTopSplash(),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Center(
                      child: Container(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        decoration: ShapeDecoration(
                            color: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(20)))),
                        child: Opacity(
                          opacity: .3,
                          child: Image.asset(
                            'assets/fundo_logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(child: Container(),),
                          Text('Encontre lanchonetes proximas a você.',
                          style: TextStyle(
                            fontSize: size.width * .04
                          ),
                          ),
                          Text('As melhores estão aqui',
                           style: TextStyle(
                            fontSize: size.width * .04
                          ),
                          ),
                          SizedBox(height: 18,)
                        ],
                      ),
                    ),
                    _button('Entrar', () {
                      Modular.to.pushNamed('signin');
                    }),
                    _button('Se registre', () {
                      Modular.to.pushNamed('signup');
                    }),
                    SizedBox(
                      height: 18,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(),
        Align(
          alignment: Alignment(0, 0),
          child: Container(
            height: size.width * .4,
            width: size.width * .4,
            child: Column(
              children: [
                Expanded(child: Image.asset('assets/logo.png')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Kit',
                      style: TextStyle(
                          fontSize: size.width * .06,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'chen',
                      style: TextStyle(
                          fontSize: size.width * .06, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
        ),
      ),
    );
  }

  _button(String text, Function onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * .8,
        child: ElevatedButton(
          child: Text(text.toUpperCase(),
          style:  TextStyle(
                                fontSize: MediaQuery.of(context).size.width * .035
                              ),
          ),
          style: ElevatedButton.styleFrom(
              primary: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)))),
          onPressed: onTap,
        ),
      ),
    );
  }
}
