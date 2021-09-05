import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/additional.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/repositories/additional.dart';
import 'package:multidelivery/src/infra/datasources/additioanal.dart';

class RepositoryAdditionalImpl extends RepositoryAdditional {
  final DatasourceAddtional datasource;
  RepositoryAdditionalImpl(this.datasource);
  @override
  Future<Either<List<ResultAdditional>, Failure>> call() async{
   try{
     return Left(await datasource.call());
   }catch(e){
     return Right(Failure(e.toString()));
   }
  }

}