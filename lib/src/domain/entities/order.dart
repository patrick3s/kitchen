import 'package:multidelivery/src/domain/entities/partner.dart';
import 'package:multidelivery/src/domain/entities/payment.dart';
import 'package:multidelivery/src/domain/entities/product.dart';
import 'package:multidelivery/src/domain/entities/usermodel.dart';

class ResultOrder {
  final ResultPartner partner;
  final DateTime createAt;
  final List<ResultProduct> products;
  final bool delivery;
  final ResultUserModel userModel;
  final double totalPrice;
  final double thing;
  final ResultFormPayment formPayment;
  ResultOrder({
    this.formPayment,
    this.partner, 
  this.createAt, 
  this.products, 
  this.delivery, 
  this.userModel, 
  this.totalPrice, 
  this.thing});
}