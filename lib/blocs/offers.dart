
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/usecase/offers.dart';
import 'package:multidelivery/src/infra/models/offer.dart';
import 'package:rxdart/subjects.dart';

abstract class OfferState {}
class SuccessOffers extends OfferState{
  final List<Offer> list;
  SuccessOffers(this.list);
}
class LoadingOffers extends OfferState{}
class IdleOffers extends OfferState{}
class ErrorOffers extends OfferState {
  final Failure fail;

  ErrorOffers(this.fail);
}
class BlocOffers {
  final AuthUser _authUser;
  final UsecaseOffers _usecase;
  final BehaviorSubject<OfferState> _controller = BehaviorSubject.seeded(IdleOffers());
  BlocOffers(this._authUser,this._usecase){
    loadOffer();
  }
  Stream<OfferState> get stream => _controller.stream;
  loadOffer()async{
    _controller.add(LoadingOffers());
    final result = await _usecase.search(_authUser.userModel.address);
    result.fold((l) => _controller.add(SuccessOffers(l)), (r) => ErrorOffers(r));
  }
  dispose(){
    _controller.close();
  }
}