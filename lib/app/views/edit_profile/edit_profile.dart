

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/blocs/usermodel.dart';
import 'package:multidelivery/controllers/profile.dart';
import 'package:multidelivery/presenters/profile.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/shared/validators.dart';
import 'package:multidelivery/utils/common_widgets.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({ Key key }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> implements ProfileContract{
  Size size;
  ProfilePresenter presenter;
  var phoneNumber = new MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
  @override
  void initState() {
    AppModule.to<Config>().showLog('EditProfile iniciada');
    super.initState();
    presenter = ProfilePresenter(this, ProfileController(
      AppModule.to<AuthUser>(),
      AppModule.to<BlocUsermodel>()
    ));

  }
@override
didChangeDependencies(){
super.didChangeDependencies();
size = MediaQuery.of(context).size;
}

  @override
  void dispose() {
    AppModule.to<Config>().showLog('EditProfile destruida');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text('Editar perfil',
        style: TextStyle(
          color: Colors.black,
          fontSize: size.width * .045
        ),
        ),
      ),
      body: StreamBuilder<UserModelState>(
        stream: presenter.controller.bloc.stream,
        builder: (context, snapshot) {
          if(snapshot.data is LoadingUserModel){
            return Center(
              child: SpinKitThreeBounce(
                color: Colors.deepOrange,
                size: size.width * 0.06,),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                _tileRow('Name', presenter.controller.userModel.name,
                 Validators.mandatory, (text) => presenter.controller.userModel.name = text),
                 _tileRow('Sobrenome', presenter.controller.userModel.lastName,
                 Validators.mandatory, (text) => presenter.controller.userModel.lastName = text),
                 _tileRow('Email', presenter.controller.userModel.email,
                 Validators.email, (text) => presenter.controller.userModel.email = text,enabled: false),
                 _tileRow('Celular', presenter.controller.userModel.phoneNumber ,
                 Validators.phoneNumber, (text) => presenter.controller.userModel.phoneNumber = text,
                 inputers: [phoneNumber]
                 ),
                 _tileRow('Data de nascimento', presenter.controller.userModel.birthday,
                 Validators.birthday, (text) => presenter.controller.userModel.birthday = text,enabled: false),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange
                  ),
                  onPressed: presenter.updateUserModel, child: Text('Atualizar'))
              ],
            ),
          );
        }
      ),
    );
  }

  _tileRow(String label,String initialValue,Function(String) validator,Function(String) onChanged , {bool enabled= true,List<TextInputFormatter> inputers }){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: TextFormField(
        initialValue: initialValue,
        inputFormatters: inputers ,
        enabled: enabled,
        style: TextStyle(
            fontSize: size.width * .045
          ),
          onChanged: onChanged,
          validator: validator,
        decoration:  InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          labelStyle: TextStyle(
            fontSize: size.width * .045
          )
        ),
      ),
    );
  }

  @override
  notification(String text) {
    notificationPopup('Atenção', text);
  }

  @override
  refresh() {
    setState(() {
      
    });
  }

  @override
  success() {
    notificationPopup('Sucesso', "Perfil atualizado");
  }
}