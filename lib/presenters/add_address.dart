import 'package:multidelivery/blocs/address.dart';
import 'package:multidelivery/controllers/add_addres.dart';

abstract class AddAddressContract {
  notification(String text);
  success();
  refresh();
}

class AddAddressPresenter {
  final AddAddressContract _contract;
  final AddAdressController controller;
  String uf;
  AddAddressPresenter(this._contract, this.controller);
  saveAddress()async{
  
    final state = await controller.saveAddress();
    if(state is ErrorAddress){
      _contract.notification(state.fail.error);
      return;
    }
    _contract.success();
  }
  getUf(String idUf){
    uf = idUf;
    controller.address['uf']=controller.getUfById(idUf)["Sigla"];
    controller.address['ufName']=controller.getUfById(idUf)["Nome"];
    controller.address['city'] = null;
    _contract.refresh();
  }
}