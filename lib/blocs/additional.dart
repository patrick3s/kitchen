import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/usecase/additional.dart';
import 'package:multidelivery/src/infra/models/additional.dart';
import 'package:rxdart/subjects.dart';

abstract class AdditionalState {}
class SuccessAdditional extends AdditionalState {
  final List<Additional> list;
  SuccessAdditional(this.list);
}

class LoadingAdditional extends AdditionalState{}
class IdleAdditional extends AdditionalState{}
class ErrorAdditional extends AdditionalState{
  final Failure fail;
  ErrorAdditional(this.fail);
}

class BlocAdditional {
  final BehaviorSubject<AdditionalState> _controller = BehaviorSubject.seeded(IdleAdditional());

  BlocAdditional(this.usecase){
    call();
  }
  Stream<AdditionalState> get stream => _controller.stream;
  AdditionalState get value => _controller.stream.value;
  final UsecaseAdditional usecase;

  call()async{
     _controller.add(LoadingAdditional());
    final result = await usecase.call();
    result.fold((l) => _controller.add(SuccessAdditional(l)), 
    (r) => _controller.add(ErrorAdditional(r)));
  }

  dispose(){
    _controller.close();
  }
}