

import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/entities/evaluation.dart';
import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/repositories/evaluation.dart';
import 'package:multidelivery/src/infra/datasources/evaluation.dart';

class RepositoryEvaluationImpl extends RepositoryEvaluation {
  final DatasourceEvaluation datasource;
  RepositoryEvaluationImpl(this.datasource);
  @override
  Future<Either<bool, Failure>> create(Map<String, dynamic> evaluation) async{
      try {
        return Left(await datasource.create(evaluation));
      }catch(e){
        return Right(Failure(e.toString()));
      }
    }
  
    @override
    Future<Either<List<ResultEvaluation>, Failure>> search(String idPartner) async{
    try{
      return Left(await datasource.search(idPartner));
    }catch(e){
      return Right(Failure(e.toString()));
    }
  }
}