import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/usermodel.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';


abstract class RepositoryUsermodel {
  Future<Either<ResultUserModel,Failure>>create(ResultUserModel userModel);
  Future<Either<ResultUserModel,Failure>>getUser(String idUser);
  Future<Either<ResultUserModel,Failure>>update(ResultUserModel userModel);
}