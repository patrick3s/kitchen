
import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/order.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/repositories/order.dart';

abstract class UsecaseOrders{
  Future<Either<ResultOrder,Failure>> create(ResultOrder order);
  Future<Either<ResultOrder,Failure>> update(ResultOrder order);
  Future<Either<List<ResultOrder>,Failure>> getAll(String idUser);
}

class UseCaseOrdersImpl extends UsecaseOrders {
  final RepositoryOrder repository;
  UseCaseOrdersImpl(this.repository);
  @override
  Future<Either<ResultOrder, Failure>> create(ResultOrder order) async{
      return await repository.create(order);
    }
  
    @override
    Future<Either<List<ResultOrder>, Failure>> getAll(String idUser) async{
      return await repository.getAll(idUser);
    }
  
    @override
    Future<Either<ResultOrder, Failure>> update(ResultOrder order) async{
    return await repository.update(order);
  }
  
}