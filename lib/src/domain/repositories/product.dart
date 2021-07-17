
import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/partner.dart';
import 'package:multidelivery/src/domain/entities/product.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';

abstract class RepositoryProduct {
  Future<Either<List<ResultProduct>,Failure>> call(ResultPartner partner);
}

