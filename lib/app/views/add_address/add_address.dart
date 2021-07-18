import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/blocs/address.dart';
import 'package:multidelivery/controllers/add_addres.dart';
import 'package:multidelivery/presenters/add_address.dart';
import 'package:multidelivery/resources/states.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/shared/validators.dart';
import 'package:multidelivery/src/externals/core.dart';
import 'package:multidelivery/utils/common_widgets.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> implements AddAddressContract {
  AddAddressPresenter presenter;
  Size size;

  @override
  void initState() {
    AppModule.to<Config>().showLog('AddAddress iniciado');
    super.initState();

    presenter = AddAddressPresenter(
        this,
        AddAdressController(BlocAddress(AppModule.to<AuthUser>(),
            AppModule.to<CoreImpl>().usecaseAddress())));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    AppModule.to<Config>().showLog('AddAddress destruido');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Adicionar um endereço',
          style: TextStyle(fontSize: size.width * .045, color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<AddressState>(
          stream: presenter.controller.bloc.stream,
          builder: (context, snapshot) {
            if (snapshot.data is LoadingAddress) {
              return Center(
                child: SpinKitThreeBounce(
                  color: Colors.deepOrange,
                  size: 26,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  _dropUf(),
                  _dropCity(),
                  _fieldText('street',
                      label: "Endereço", validator: Validators.mandatory),
                  _fieldText('numberHome',
                      label: "Numero da casa",
                      validator: Validators.mandatory,
                      keyboardType: TextInputType.number),
                  _fieldText('district',
                      label: "Bairro", validator: Validators.mandatory),
                  _fieldText('reference',
                      label: "Referencia",
                      validator: Validators.mandatory,
                      hintText: "Informe um local proximo ao seu endereço"),
                  _fieldText('complement',
                      label: "Complemento",
                      validator: Validators.mandatory,
                      hintText: "Casa, Apartamento ..."),
                      ElevatedButton(onPressed: presenter.saveAddress, 
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange
                      ),
                      child: Text('Salvar',
                      style: TextStyle(
                        fontSize: size.width * .045,
                        fontWeight: FontWeight.bold
                      ),
                      ))
                ],
              ),
            );
          }),
    );
  }

  @override
  notification(String text) {
    notificationPopup('Atenção', text);
  }

  @override
  success() {
    Modular.to.pop();
  }

  _fieldText(String key,
      {String label,
      String hintText,
      Function(String) validator,
      TextInputType keyboardType,
      List<TextInputFormatter> inputFormatters,
      int maxLength}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        initialValue: presenter.controller.address[key],
        maxLength: maxLength,
        validator: validator,
        keyboardType: keyboardType,
        onChanged: (text) {
          presenter.controller.address[key] = text;
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
    final list = presenter.controller.getCityByIdUf(presenter.uf);
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
        value: presenter.controller.address['city'],
        style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * .035),
        onChanged: (text) {
          presenter.controller.address['city'] = text;
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

  @override
  refresh() {
    setState(() {});
  }
}
