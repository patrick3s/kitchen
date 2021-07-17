
import 'package:multidelivery/src/domain/entities/partner.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/repositories/partners.dart';
import 'package:multidelivery/src/infra/datasources/partners.dart';

class RepositoryPartnersImpl extends RepositoryPartner {
  final DatasourcePartners _datasource;

  RepositoryPartnersImpl(this._datasource);
  @override
  Future<Either<List<ResultPartner>, Failure>> search(Map city) async {
    try {
      return Left(await _datasource.search(city));
    }catch(e){
      return Right(Failure(e.toString()));
    }
    
  }
}