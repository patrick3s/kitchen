import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/offer.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/repositories/offers.dart';


abstract class UsecaseOffers {
  Future<Either<List<ResultOffer>,Failure>> search(Map city);
}
class UsecaseOffersImpl extends UsecaseOffers {
  final RepositoryOffers _repository;

  UsecaseOffersImpl(this._repository);
  @override
  Future<Either<List<ResultOffer>, Failure>> search(Map city) async{
    return await _repository.search(city);
  }
}