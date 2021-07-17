import 'package:multidelivery/src/infra/models/offer.dart';

abstract class DatasourceOffers {
  Future<List<Offer>> search(Map city);
}