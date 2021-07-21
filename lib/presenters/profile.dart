import 'package:multidelivery/blocs/usermodel.dart';
import 'package:multidelivery/controllers/profile.dart';

abstract class ProfileContract {
  refresh();
  notification(String text);
  success();
}

class ProfilePresenter {
  final ProfileContract contract;
  final ProfileController controller;
  ProfilePresenter(this.contract, this.controller);

  updateUserModel()async{
    final state = await controller.updateUser();
    if(state is ErrorUserModel){
      contract.notification(state.fail.error);
      return;
    }
    contract.success();
  }

}