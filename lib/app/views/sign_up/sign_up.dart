import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/controllers/singup.dart';
import 'package:multidelivery/presenters/signup.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/shared/icons_platform.dart';
import 'package:multidelivery/shared/pallete_colors.dart';
import 'package:multidelivery/shared/validators.dart';


class SignUp extends StatefulWidget {
  const SignUp({ Key key }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> implements SignUpContract {
  Size size;
  SingUpPresenter presenter;
  final style = TextStyle(
    fontWeight: FontWeight.bold
  );
  @override
  void initState() {
    super.initState();
    AppModule.to<Config>().showLog('Sign up iniciado');
    presenter= SingUpPresenter(this, ControllerSingUp(),AppModule.to<AuthUser>());
  }
  @override
  void dispose() {
   AppModule.to<Config>().showLog('Sign up destruido');
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
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: ValueListenableBuilder<STATUSUSER>(
        valueListenable: presenter.auth.status,
        builder: (context, status,chid) {
          return IgnorePointer(
            ignoring: status == STATUSUSER.LOADING,
            child: SafeArea(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal :10.0),
              child: Form(
                key: presenter.form,
                child: Stack(
                  children: [
                    ListView(
                          children: [
                            Center(child: Padding(
                                    padding:EdgeInsets.symmetric(vertical:size.height * .03),
                                    child: Text('Registre-se',
                                    style: TextStyle(fontSize: size.width * .06),
                                    ),
                                  )),
                                _fieldText('email',icon: false, label: 'Email',
                                hintText: 'Informe seu email',
                                validator: Validators.email
                                ),
                                SizedBox(height: size.width * .05),
                                _fieldText('password',icon: true, label: 'Senha',
                                hintText: 'Crie uma senha segura',
                                validator: Validators.password
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text('Dicas de segurança',
                                    style: style.copyWith(
                                      
                                      fontSize: size.width * .05),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    ...presenter.safetyTip.map((e) => Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(e,
                                      style: TextStyle(
                                        fontSize: size.width * .04
                                      ),
                                      ),
                                    )).toList()
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top:30.0),
                                  child: Column(
                                    children: [
                                      Text('Ao criar conta você estará concordando com os',
                                      style: style.copyWith(
                                        fontSize: size.width * .04
                                      ),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          Modular.to.pushNamed('/webview');
                                        },
                                        child: Text('termos do aplicativo.',
                                        style: style.copyWith(
                                        color: Colors.blue,
                                        fontSize: size.width * .04
                                        ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top:20),
                                child: _button('Criar conta', presenter.createAccount),
                                )
                          ],
                        ),
                        status == STATUSUSER.LOADING ?
                        Container(
                          color: Colors.black26 ,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ) : Container()
                  ],
                ),
              ),
            )),
          );
        }
      ),
    );
  }

  _fieldText(String key,{bool icon, bool obscure, String hintText, String label, Function(String) validator}){
    return FormField<bool>(
      initialValue: obscure ?? false,
      builder: (state) {
        return TextFormField(
          initialValue: presenter.map[key] ?? '',
            obscureText: state.value,
            style: TextStyle(
              fontSize: size.width * .042
            ),
            validator: validator,
          decoration: InputDecoration(
            suffixIcon: icon == true ? InkWell(
              onTap: (){
                state.didChange(!state.value);
              },
              child: Icon(!state.value ? IconsPlatform.lockOpen : IconsPlatform.lock,
              )) : Icon(IconsPlatform.email),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))
          ),
          labelText: label,
          hintText: hintText,
        ),
          onChanged: (text){
            presenter.map[key] = text;
          },
        );
      }
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
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text,
      style: TextStyle(
        fontSize: size.width * .04
      ),
      ),
      backgroundColor: Colors.red,
      
      )
    );
  }
}