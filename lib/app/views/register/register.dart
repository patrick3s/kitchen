import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/controllers/register.dart';
import 'package:multidelivery/presenters/register.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:multidelivery/resources/states.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/pallete_colors.dart';
import 'package:multidelivery/shared/validators.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> implements RegisterContract {
  Size size;
  RegisterPresenter presenter;
  var phoneNumber = new MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
  var birthday = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  @override
  void initState() {
    super.initState();
    presenter = RegisterPresenter(this, AppModule.to<AuthUser>());
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
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: ValueListenableBuilder<STATUSUSER>(
          valueListenable: presenter.authUser.status,
          builder: (context, status,child) {
            return IgnorePointer(
              ignoring: status == STATUSUSER.LOADING,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      key: presenter.form,
                      child: ListView(
                        children: [
                          _fieldText('name',
                             // maxLength: 25,
                              label: 'Nome',
                              validator: Validators.mandatory),
                          _fieldText('lastName',
                             // maxLength: 28,
                              label: 'Sobrenome',
                              validator: Validators.mandatory),
                          _fieldText('phoneNumber',
                              label: 'Celular',
                              inputFormatters: [phoneNumber],
                              validator: Validators.phoneNumber,
                              keyboardType: TextInputType.number),
                          _fieldText('birthday',
                              label: 'Data de nascimento',
                              inputFormatters: [birthday],
                              validator: Validators.birthday),
                          _dropUf(),
                          _dropCity(),
                          _fieldText('street',
                              label: "Endereço", 
                              address: true,
                              validator: Validators.mandatory),
                          _fieldText('numberHome',
                              label: "Numero da casa",
                              address: true,
                              validator: Validators.mandatory,
                              keyboardType: TextInputType.number),
                          _fieldText('district',
                          address: true,
                              label: "Bairro", validator: Validators.mandatory),
                          _fieldText('reference',
                              label: "Referencia",
                              address: true,
                              validator: Validators.mandatory,
                              hintText: "Informe um local proximo ao seu endereço"),
                          _fieldText('complement',
                              label: "Complemento",
                              address: true,
                              validator: Validators.mandatory,
                              hintText: "Casa, Apartamento ..."),
                          _button('Salvar', presenter.save)
                        ],
                      ),
                    ),
                  ),
                  status == STATUSUSER.LOADING ? 
                  Container(
                    color: Colors.black26,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ): Container()
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  _fieldText(String key,
      {String label,
      String hintText,
      bool address = false,
      Function(String) validator,
      TextInputType keyboardType,
      List<TextInputFormatter> inputFormatters,
      int maxLength}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        initialValue:address ? presenter.map['address'][key] : presenter.map[key],
        maxLength: maxLength,
        validator: validator,
        keyboardType: keyboardType,
        onChanged: (text){
          address ? presenter.map['address'][key] = text :
          presenter.map[key] =text;
        },
        inputFormatters: inputFormatters,
        style: TextStyle(fontSize: size.width * .045),
        decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)))),
      ),
    );
  }

  _dropCity() {
    final list = ControllerRegister.getCityByIdUf(presenter.uf);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton(
        
        items: [
          ...list
              .map((e) => DropdownMenuItem(
                    value: e["Nome"],
                    child: Text(
                      e['Nome'],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * .035),
                    ),
                  ))
              .toList()
        ],
        value: presenter.map['address']['city'],
        
        style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * .035),
        onChanged: (text) {
          presenter.map['address']['city'] = text;
          setState(() {});
        },
        hint: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Cidade',
            style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * .035),
          ),
        ),
        isExpanded: true,
      ),
    );
  }

  _dropUf() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<String>(
        value: presenter.uf,
        style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * .035),
        items: [
          ...state
              .map((e) => DropdownMenuItem<String>(
                  value: e['ID'],
                  child: Text(
                    e['Nome'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * .035),
                  )))
              .toList()
        ],
        onChanged: presenter.getUf,
        hint: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Estado',
            style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * .035),
          ),
        ),
        isExpanded: true,
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
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * .04),
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
          style: TextStyle(fontSize: size.width * .04, color: Colors.white),
        )));
  }

  @override
  refresh() {
    setState(() {});
  }
}
