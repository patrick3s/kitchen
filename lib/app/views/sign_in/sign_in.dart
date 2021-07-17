import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/presenters/signin.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/shared/icons_platform.dart';

import 'package:multidelivery/shared/pallete_colors.dart';
import 'package:multidelivery/shared/validators.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> implements SigninContract {
  Size size;
  SigninPresenter presenter;
  @override
  void initState() {
    super.initState();
    AppModule.to<Config>().showLog('Sign in iniciado');
    presenter = SigninPresenter(this, AppModule.to<AuthUser>());
  }

  @override
  void dispose() {
    AppModule.to<Config>().showLog('Sign in destruido');
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ValueListenableBuilder(
          valueListenable: presenter.auth.status,
          builder: (context, status, child) {
            return IgnorePointer(
              ignoring: status == STATUSUSER.LOADING,
              child: Stack(
                children: [
                  Form(
                    key: presenter.form,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView(
                        children: [
                          Center(
                              child: Padding(
                            padding: EdgeInsets.only(bottom: size.height * .08),
                            child: Text(
                              'Entrar',
                              style: TextStyle(fontSize: size.width * .08),
                            ),
                          )),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Adicione suas informações para entrar',
                                style: TextStyle(fontSize: size.width * .04),
                              ),
                            ),
                          ),
                          _keyboardInput('email',
                              label: "Email", validator: Validators.email),
                          _keyboardInput('password',
                              label: "Senha",
                              icon: true,
                              validator: Validators.password,
                              obscure: true),
                          _button('Entrar', presenter.signIn),
                          _button('Se registre', () {
                            Modular.to.pushReplacementNamed('signup');
                          }),
                          Center(
                            child: Text(
                              '-- ou --',
                              style: TextStyle(fontSize: size.width * .04),
                            ),
                          ),
                          SignInButton(Buttons.GoogleDark,
                              mini: false,
                              text: 'Entrar com Google',
                              onPressed: presenter.signInGoogle),
                          Platform.isAndroid ? SignInButton(Buttons.Facebook,
                          text: "Entrar com Facebook",
                           onPressed: presenter.signInFacebook) : Container(),
                          Platform.isIOS ? SignInButton(Buttons.AppleDark, 
                          text: "Entrar com a Apple",
                          onPressed: presenter.signInApple) : Container()
                        ],
                      ),
                    ),
                  ),
                  status == STATUSUSER.LOADING
                      ? Container(
                          color: Colors.black38,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            );
          }),
    );
  }

  _keyboardInput(String keyMap,
      {bool icon,
      String label,
      String hintText,
      Function(String) validator,
      bool obscure = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * .02),
      child: Form(
        child: FormField<bool>(
            initialValue: false,
            builder: (state) {
              return TextFormField(
                initialValue: presenter.map[keyMap] ?? '',
                style: TextStyle(fontSize: size.width * .045),
                validator: validator,
                obscureText: state.value,
                onChanged: (text) {
                  presenter.map[keyMap] = text;
                },
                decoration: InputDecoration(
                  suffixIcon: icon == true
                      ? InkWell(
                          onTap: () {
                            state.didChange(!state.value);
                          },
                          child: Icon(state.value
                              ? IconsPlatform.lock
                              : IconsPlatform.lockOpen))
                      : Icon(IconsPlatform.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  labelText: label,
                  hintText: hintText,
                ),
              );
            }),
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
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .035,
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

  @override
  error(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: size.width * .04),
        )));
  }
}
