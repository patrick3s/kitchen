
import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/category.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/repositories/category.dart';
import 'package:multidelivery/src/infra/datasources/category.dart';

class RepositoryCategoryImpl extends RepositoryCategory {
  final DatasourceCategory datasource;

  RepositoryCategoryImpl(this.datasource);

  @override
  Future<Either<List<ResultCategory>, Failure>> search() async{
    try {
      return Left(await datasource.search());
    }catch(e){
      return Right(Failure(e.toString()));
    }
  }
}