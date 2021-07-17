
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/entities/offer.dart';
import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/repositories/offers.dart';
import 'package:multidelivery/src/infra/datasources/offers.dart';

class RepositoryOffersImpl extends RepositoryOffers {
  final DatasourceOffers _datasource;

  RepositoryOffersImpl(this._datasource);
  @override
  Future<Either<List<ResultOffer>, Failure>> search(Map city) async{
    try{
      return Left(await _datasource.search(city));
    }catch(e){
      return Right(Failure(e.toString()));
    }
  }

}