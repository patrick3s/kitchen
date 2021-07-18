
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/usecase/usermodel.dart';
import 'package:multidelivery/src/infra/models/usermodel.dart';
import 'package:rxdart/subjects.dart';

abstract class UserModelState {}

class SuccessUserModel extends UserModelState{
  final UserModel userModel;
  SuccessUserModel(this.userModel);
}

class LoadingUserModel extends UserModelState {}
class ErrorUserModel extends UserModelState {
  final Failure fail;

  ErrorUserModel(this.fail);
}
class IdleUserModel extends UserModelState {}

class BlocUsermodel {
  final AuthUser auth;
  final UsecaseUserModel usecase;
  final BehaviorSubject<UserModelState> _controller = BehaviorSubject.seeded(IdleUserModel());
  Stream<UserModelState> get stream => _controller.stream;
  BlocUsermodel(this.auth, this.usecase);

  Future<UserModelState> update(UserModel userModel)async{
    UserModelState state;
    _controller.add(LoadingUserModel());
    final result = await usecase.update(userModel);
    result.fold((l) {
      state =SuccessUserModel(l);
      _controller.add(state);
    }, (r) {
         state = ErrorUserModel(r);
        _controller.add(state);
    });
    return state;
  }

  dispose(){
    _controller.close();
  }
}