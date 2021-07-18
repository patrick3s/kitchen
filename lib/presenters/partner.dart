
import 'package:multidelivery/blocs/usermodel.dart';
import 'package:multidelivery/controllers/partner.dart';


abstract class PartnerContract {
  refresh();
  notification(String text);
}

class PartnerPresenter {
  final PartnerContract _contract;
  final PartnerController controller;

  PartnerPresenter(this._contract, this.controller);

  listnerScrollBody(){
    controller.listnerScrollBody((){_contract.refresh();});
  }

  favorite(){
    final state =controller.favoriteParter();
    if(state is ErrorUserModel){
      _contract.notification(state.fail.error);
    }
    
  }
}