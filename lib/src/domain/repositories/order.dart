import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/order.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';

abstract class RepositoryOrder {
  Future<Either<ResultOrder,Failure>> create(ResultOrder order);
  Future<Either<ResultOrder,Failure>> update(ResultOrder order);
  Future<Either<List<ResultOrder>,Failure>> getAll(String idUser);
}