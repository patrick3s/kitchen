import 'package:multidelivery/src/infra/models/additional.dart';

abstract class DatasourceAddtional {
  Future<List<Additional>> call();
}