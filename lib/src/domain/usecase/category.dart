import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/category.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/repositories/category.dart';


abstract class UsecaseCategory {
  Future<Either<List<ResultCategory>,Failure>> search();
}

class UsecaseCategoryImpl extends UsecaseCategory {
  final RepositoryCategory repository;

  UsecaseCategoryImpl(this.repository);

  @override
  Future<Either<List<ResultCategory>, Failure>> search() async{
    return await repository.search();
  }
}

