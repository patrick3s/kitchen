import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/entities/order.dart';
import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/repositories/order.dart';
import 'package:multidelivery/src/infra/datasources/orders.dart';

class RepositoryOrderImple extends RepositoryOrder {
  final DatasourceOrders datasource;
  RepositoryOrderImple(this.datasource);
  @override
  Future<Either<ResultOrder, Failure>> create(ResultOrder order)async {
      try{
        return Left(await datasource.create(order));
      }catch(e){
        return Right(Failure(e.toString()));
      }
    }

    @override
    Future<Either<List<ResultOrder>, Failure>> getAll(String idUser) async{
      try{
        return Left(await datasource.getAll(idUser));
      }catch(e){
        return Right(Failure(e.toString()));
      }
    }

    @override
    Future<Either<ResultOrder, Failure>> update(ResultOrder order) async {
    try{
      return Left(await datasource.update(order));
    }catch(e){
      return Right(Failure(e.toString()));
    }
  }
}