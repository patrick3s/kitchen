

import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/entities/product.dart';
import 'package:multidelivery/src/domain/entities/partner.dart';
import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/repositories/product.dart';
import 'package:multidelivery/src/infra/datasources/product.dart';

class RepositoryProductImpl extends RepositoryProduct {
  final DatasourceProduct datasource;

  RepositoryProductImpl(this.datasource);
  @override
  Future<Either<List<ResultProduct>, Failure>> call(ResultPartner partner)async {
    try{
      return Left(await datasource.call(partner));
    }catch(e){
      return Right(Failure(e.toString()));
    }
  }
}