



import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/usecase/partners.dart';
import 'package:multidelivery/src/infra/models/partner.dart';
import 'package:rxdart/subjects.dart';

abstract class PartnerState {}

class SuccessPartner extends PartnerState {
  final List<Partner> list;
  SuccessPartner(
    this.list,
  );
}
class IdlePartner extends PartnerState {}
class LoadingPartner extends PartnerState{}
class ErrorPartner extends PartnerState{
  final Failure error;
  ErrorPartner(this.error);
}

class BlocPartners {
  final AuthUser _authUser;
  final UsecasePartner _usecase;
  final BehaviorSubject<PartnerState> _controller = BehaviorSubject.seeded(IdlePartner());
  BlocPartners(this._authUser,this._usecase){
    searchPartners();
  }
  Stream<PartnerState> get stream => _controller.stream;
  PartnerState get partners => _controller.stream.value;
  searchPartners()async{
    _controller.add(LoadingPartner());
    final result = await _usecase.search(_authUser.userModel.address);
    result.fold((l) => _controller.add(SuccessPartner(l)), (r) => _controller.add(ErrorPartner(r)));
  }
  dispose(){
    _controller.close();
  }
}