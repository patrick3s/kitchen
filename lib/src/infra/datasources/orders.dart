import 'package:multidelivery/src/infra/models/order.dart';

abstract class DatasourceOrders {
  Future<Order> create(Order order);
  Future<Order> update(Order order);
  Future<List<Order>> getAll(String idUser);
}