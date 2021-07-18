import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';

abstract class RepositoryAddress {
  Future<Either<bool,Failure>> create(Map<String,dynamic> address,String idUser);
  Future<Either<bool,Failure>> delete(String idDoc,String idUser);
}

