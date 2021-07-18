import 'package:multidelivery/blocs/usermodel.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/src/infra/models/usermodel.dart';

class AddressController {
  final BlocUsermodel bloc;
  final AuthUser auth;
  AddressController(this.bloc, this.auth);

  selectAddress(Map<String,dynamic> address)async {
    final user = UserModel.fromMap(auth.userModel.toMap()..['address'] = address);
    user.id = auth.user.uid;
    final state = await bloc.update(user);
    if(state is SuccessUserModel){
      auth.userModel = user;
    }
    return state;
  }
}