import 'package:multidelivery/blocs/usermodel.dart';
import 'package:multidelivery/controllers/address.dart';

abstract class AddressContract {
  success();
  notification(String text);
}

class AddressPresenter {
  final AddressContract contract;
  final AddressController controller;

  AddressPresenter(this.contract, this.controller);

  selectAddress(Map<String,dynamic> address)async{
    final update = await controller.selectAddress(address);
    if(update is ErrorUserModel){
      contract.notification(update.fail.error);
      return;
    }
     contract.success();
  }
}
