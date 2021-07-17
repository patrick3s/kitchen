import 'package:multidelivery/src/domain/usecase/evaluation.dart';

import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/infra/models/evaluation.dart';
import 'package:rxdart/subjects.dart';

abstract class EvaluationState {}

class IdleEvaluation extends EvaluationState {}

class LoadingEvaluation extends EvaluationState {}

class SuccessEvaluation extends EvaluationState {
  final List<Evaluation> list;
  SuccessEvaluation({this.list});
}

class ErrorEvaluation extends EvaluationState {
  final Failure error;
  ErrorEvaluation(this.error);
}

class BlocEvaluation {
  final UsecaseEvaluation usecaseEvaluation;
  final BehaviorSubject<EvaluationState> _controller =
      BehaviorSubject.seeded(IdleEvaluation());

  BlocEvaluation(this.usecaseEvaluation);
  Stream<EvaluationState> get stream => _controller.stream;
  load(String idPartner) async {
    _controller.add(LoadingEvaluation());
    final result = await usecaseEvaluation.search(idPartner);
    result.fold((l) => _controller.add(SuccessEvaluation(list: l)),
        (r) => _controller.add(ErrorEvaluation(r)));
  }

  Future<bool> create(Map<String, dynamic> evaluation) async {
    _controller.add(LoadingEvaluation());
    final result = await usecaseEvaluation.create(evaluation);
    return result.fold((l) {
      _controller.add(SuccessEvaluation());
      return true;
    }, (r) {
      _controller.add(ErrorEvaluation(r));
      return false;
    });
  }

  dispose() {
    _controller.close();
  }
}
