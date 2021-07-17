import 'package:multidelivery/src/domain/entities/product.dart';

class ResultOffer {
  final String title;
  final String id;
  final double price;
  final String img;
  final ResultProduct product;
  final int discount;
  final String city;
  final String uf;
  final String district;
  final String complement;
  final String street;
  final String numberHome;
  final String reference;

  ResultOffer(
      {
        this.id
      ,this.title,
      this.price,
      this.img,
      this.product,
      this.discount,
      this.city,
      this.uf,
      this.district,
      this.complement,
      this.street,
      this.numberHome,
      this.reference});
    
}
