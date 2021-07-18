
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/usecase/address.dart';
import 'package:rxdart/subjects.dart';

abstract class AddressState{}

class LoadingAddress extends AddressState {}
class SuccessAddress extends AddressState {}
class ErrorAddress extends AddressState {
  final Failure fail;
  ErrorAddress(this.fail);
}

class IdleAddress extends AddressState {}

class BlocAddress {
  final BehaviorSubject<AddressState> _controller = BehaviorSubject.seeded(IdleAddress());
  final AuthUser auth;
  final UsecaseAddress usecase;
  BlocAddress(this.auth, this.usecase);
  Stream<AddressState> get stream => _controller.stream;
  create(Map<String,dynamic> address)async{
    _controller.add(LoadingAddress());
    final result = await usecase.create(address,auth.user.uid);
    AddressState state;
    result.fold((l) {
      state = SuccessAddress();
      _controller.add(state);
    }, (r) {
      state = ErrorAddress(r);
      _controller.add(state);
    });
    return state;
  }

  dispose(){
    _controller.close();
  }
}