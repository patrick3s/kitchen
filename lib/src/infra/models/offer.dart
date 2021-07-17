
import 'dart:convert';

import 'package:multidelivery/src/domain/entities/offer.dart';
import 'package:multidelivery/src/infra/models/product.dart';

class Offer extends ResultOffer {
  final String id;
  final String title;
  final double price;
  final String img;
  final Product product;
  final int discount;
  final String city;
  final String uf;
  final String district;
  final String complement;
  final String street;
  final String numberHome;
  final String reference;

  Offer({this.id,this.title, this.price, this.img, this.product, this.discount, this.city, this.uf, this.district, this.complement, this.street, this.numberHome, this.reference});

  Map<String, dynamic> toMap() {
    
    return {
      'id':id,
      'title': title,
      'price': price,
      'img': img,
      'product': product.toMap(),
      'discount': discount,
      'city': city,
      'uf': uf,
      'district': district,
      'complement': complement,
      'street': street,
      'numberHome': numberHome,
      'reference': reference,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    
    return Offer(
      id: map['id'],
      title: map['title'],
      price: map['price'] + 0.0,
      img: map['img'],
      product: Product.fromMap(map['product']),
      discount: map['discount'],
      city: map['city'],
      uf: map['uf'],
      district: map['district'],
      complement: map['complement'],
      street: map['street'],
      numberHome: map['numberHome'],
      reference: map['reference'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Offer.fromJson(String source) => Offer.fromMap(json.decode(source));
  }
