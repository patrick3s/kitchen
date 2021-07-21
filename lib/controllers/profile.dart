import 'package:multidelivery/blocs/usermodel.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/src/infra/models/usermodel.dart';

class ProfileController {
  final AuthUser auth;
  final BlocUsermodel bloc;
  UserModel userModel;
  ProfileController(this.auth, this.bloc){
    userModel = UserModel.fromMap(auth.userModel.toMap());
    userModel.id = auth.user.uid;
  }

  Future<UserModelState> updateUser() async{
    print(userModel.id);
    print(userModel.toMap());
    
    final state = await bloc.update(userModel);
    if(state is SuccessUserModel){
      auth.userModel = userModel;
      return state;
    }
    return state;
  }
}