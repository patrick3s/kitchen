import 'package:multidelivery/src/domain/entities/category.dart';
import 'package:multidelivery/src/domain/entities/product.dart';

class ResultPartner {
  final String id;
  final String name;
  final String city;
  final bool isOpen;
  final String uf;
  final String img;
  final String backgrounImg;
  final String district;
  final String complement;
  final String street;
  final String numberHome;
  final double deliveryPrice;
  final String reference;
  final String phoneNumber;
  final bool delivery;
  final String deliveryTime;
  final DateTime createAt;
  final List<String> credit;
  final List<String> debit;
  final double averange;
  final ResultCategory specialtyCategory;
  final String description;
  final List<ResultCategory> categories;
  final List<ResultProduct> products;
  
  ResultPartner(
      {this.id,
      this.name,
      this.city,
      this.isOpen,
      this.uf,
      this.img,
      this.credit,
      this.debit,
      this.backgrounImg,
      this.deliveryPrice,
      this.district,
      this.complement,
      this.street,
      this.numberHome,
      this.reference,
      this.phoneNumber,
      this.delivery,
      this.deliveryTime,
      this.createAt,
      this.averange,
      this.specialtyCategory,
      this.description,
      this.categories,
      this.products});
}
