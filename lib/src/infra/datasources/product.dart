import 'package:multidelivery/src/domain/entities/partner.dart';
import 'package:multidelivery/src/infra/models/product.dart';

abstract class DatasourceProduct {
  Future<List<Product>> call(ResultPartner partner);
}