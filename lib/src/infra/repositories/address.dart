import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/repositories/address.dart';
import 'package:multidelivery/src/infra/datasources/address.dart';

class RepositoryAddressImple extends RepositoryAddress {
  final DatasourceAddress datasource;

  RepositoryAddressImple(this.datasource);
  @override
  Future<Either<bool, Failure>> create(Map<String, dynamic> address,String idUser) async{
    try{
      return Left(await datasource.create(address,idUser));
    }catch(e){
      return Right(Failure(e.toString()));
    }
  }

  @override
  Future<Either<bool, Failure>> delete(String idDoc, String idUser)async {
    try{
      return Left(await datasource.delete(idDoc, idUser));
    }catch(e){
      return Right(Failure(e.toString()));
    }
  }

}