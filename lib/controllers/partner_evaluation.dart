import 'package:multidelivery/src/infra/models/evaluation.dart';

class PartnerEvaluationController {
List<Evaluation> evaluations = [];
  organizerEvaluationsByDate(List<Evaluation> list){
    evaluations.clear();
    evaluations.addAll(list);
    Comparator<Evaluation> comparatorDateEvaluation = 
    (a,b) => a.createAt.compareTo(b.createAt);
    evaluations.sort(comparatorDateEvaluation);
  }
}