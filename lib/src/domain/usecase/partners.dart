import 'package:dartz/dartz.dart';
import 'package:multidelivery/src/domain/entities/partner.dart';
import 'package:multidelivery/src/domain/erros/datasource.dart';
import 'package:multidelivery/src/domain/repositories/partners.dart';

abstract class UsecasePartner {
  Future<Either<List<ResultPartner>,Failure>> search(Map city);
}

class UsecasePartnerImple extends UsecasePartner{
  final RepositoryPartner _repository;

  UsecasePartnerImple(this._repository);

  @override
  Future<Either<List<ResultPartner>, Failure>> search(Map city) async{
    return await _repository.search(city);
  }

}