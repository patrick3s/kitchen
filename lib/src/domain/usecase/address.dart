
import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/repositories/address.dart';

abstract class UsecaseAddress {
  Future<Either<bool,Failure>> create(Map<String,dynamic> address,String idUser);
  Future<Either<bool,Failure>> delete(String idDoc,String idUser);
}

class UsecaseAddressImpl extends UsecaseAddress {
  final RepositoryAddress repository;

  UsecaseAddressImpl(this.repository);
  @override
  Future<Either<bool, Failure>> create(Map<String, dynamic> address,String idUser) async{
    return await repository.create(address,idUser);
  }

  @override
  Future<Either<bool, Failure>> delete(String idDoc, String idUser) async{
    return await repository.delete(idDoc, idUser);
  }
}