import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/usermodel.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/repositories/usermodel.dart';

abstract class UsecaseUserModel {
  Future<Either<ResultUserModel,Failure>>create(ResultUserModel userModel);
  Future<Either<ResultUserModel,Failure>>getUser(String idUser);
  Future<Either<ResultUserModel,Failure>>update(ResultUserModel userModel);
}


class UsecaseUserModelImpl extends UsecaseUserModel {
  final RepositoryUsermodel repository;

  UsecaseUserModelImpl(this.repository);
  @override
  Future<Either<ResultUserModel, Failure>> create(ResultUserModel userModel) async{
      return await repository.create(userModel);
    }
  
    @override
    Future<Either<ResultUserModel, Failure>> getUser(String idUser) async{
      return await repository.getUser(idUser);
    }
  
    @override
    Future<Either<ResultUserModel, Failure>> update(ResultUserModel userModel)async {
    return await repository.update(userModel);
  }

}