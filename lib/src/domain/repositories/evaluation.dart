import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/evaluation.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';

abstract class RepositoryEvaluation {
  Future<Either<bool,Failure>> create(Map<String,dynamic> evaluation);
  Future<Either<List<ResultEvaluation>,Failure>> search(String idPartner);
}