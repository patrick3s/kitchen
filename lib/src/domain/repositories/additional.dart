import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/additional.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';

abstract class RepositoryAdditional {
 Future<Either<List<ResultAdditional>,Failure>> call();
}