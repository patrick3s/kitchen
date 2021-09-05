

import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/additional.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/repositories/additional.dart';

abstract class UsecaseAdditional {
 Future<Either<List<ResultAdditional>,Failure>> call();
}

class UsecaseAdditionalImpl extends UsecaseAdditional {
  final RepositoryAdditional repository;

  UsecaseAdditionalImpl(this.repository);
  @override
  Future<Either<List<ResultAdditional>, Failure>> call() async{
    return await repository.call();
  }

}