import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/evaluation.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/repositories/evaluation.dart';

abstract class UsecaseEvaluation {
  Future<Either<bool,Failure>> create(Map<String,dynamic> evaluation);
  Future<Either<List<ResultEvaluation>,Failure>> search(String idPartner);
}

class UsecaseEvaluationImpl extends UsecaseEvaluation {
  final RepositoryEvaluation repository;

  UsecaseEvaluationImpl(this.repository);
  @override
  Future<Either<bool, Failure>> create(Map<String,dynamic> evaluation) async{
    return await repository.create(evaluation);
  }

  @override
  Future<Either<List<ResultEvaluation>, Failure>> search(String idPartner) async{
    return await repository.search(idPartner);
  }
}