import 'package:multidelivery/blocs/evaluation.dart';
import 'package:multidelivery/controllers/evaluation.dart';

abstract class EvaluationContract {
  success();
  notification(String text);
}


class EvaluationPresenter  {
  final EvaluationContract contract;
  final EvaluationController controller;

  EvaluationPresenter(this.contract, this.controller);

  evaluation()async{
    final evaluation = await controller.saveEvaluation();
    if(evaluation is ErrorEvaluation){
      contract.notification(evaluation.error.error);
      return;
    }
    contract.success();
  }
}