import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/category.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';

abstract class RepositoryCategory {
  Future<Either<List<ResultCategory>,Failure>> search();
}