

import 'package:multidelivery/src/domain/entities/usermodel.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';

import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/repositories/usermodel.dart';
import 'package:multidelivery/src/infra/datasources/usermodel.dart';
import 'package:multidelivery/src/infra/models/usermodel.dart';

class RepositoryUserModelImpl extends RepositoryUsermodel {
  final DatasourceUserModel datasource;

  RepositoryUserModelImpl(this.datasource);
  @override
  Future<Either<UserModel, Failure>> create(ResultUserModel userModel) async{
     try{
       return Left(await datasource.create(userModel));
     }catch(e){
       return Right(Failure(e.toString()));
     }
    }
  
    @override
    Future<Either<UserModel, Failure>> getUser(String idUser) async{
      try{
        return Left(await datasource.getUser(idUser));
      }catch(e){
        return Right(Failure(e.toString()));
      }
    }
  
    @override
    Future<Either<UserModel, Failure>> update(ResultUserModel userModel) async{
    try{
      return Left(await datasource.update(userModel));
    }catch(e){
      return Right(Failure(e.toString()));
    }
  } 
}