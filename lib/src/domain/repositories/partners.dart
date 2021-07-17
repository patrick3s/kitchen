import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/partner.dart';

import 'package:multidelivery/src/domain/erros/datasource.dart';

abstract class RepositoryPartner {
  Future<Either<List<ResultPartner>,Failure>> search(Map city);
}