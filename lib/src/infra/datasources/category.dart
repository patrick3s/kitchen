
import 'package:multidelivery/src/infra/models/category.dart';

abstract class DatasourceCategory {
  Future<List<Category>> search();
}