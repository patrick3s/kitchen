import 'package:multidelivery/src/infra/models/evaluation.dart';

abstract class DatasourceEvaluation {
  Future<bool> create(Map<String,dynamic> evaluation);
  Future<List<Evaluation>> search(String idPartner);
}