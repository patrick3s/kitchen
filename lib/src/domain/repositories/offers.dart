import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/offer.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';

abstract class RepositoryOffers {
 Future<Either<List<ResultOffer>,Failure>> search(Map city);
}