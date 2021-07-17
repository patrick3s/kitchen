

import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/partner.dart';
import 'package:multidelivery/src/domain/entities/product.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/repositories/product.dart';

abstract class UsecaseProduct {
  Future<Either<List<ResultProduct>,Failure>> call(ResultPartner partner);
}

class UsecaseProductImpl extends UsecaseProduct{
  final RepositoryProduct repository;
  UsecaseProductImpl(this.repository);
  @override
  Future<Either<List<ResultProduct>, Failure>> call(ResultPartner partner) async{
    return await repository.call(partner);
  }
}