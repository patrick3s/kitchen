import 'dart:convert';

import 'package:multidelivery/src/domain/entities/additional.dart';

class Additional extends ResultAdditional{
  final String title;
  final int limit;
  final String description;
  final double price;
  bool free;
  final bool mandatory;
  final String category;
  final String img;
  bool checkBox;
   int quantity;
  Additional({
    this.quantity,
     this.title,
     this.limit,
     this.mandatory,
     this.img,
     this.category,
     this.free,
     this.description,
     this.price,
     this.checkBox,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'limit': limit,
      'description': description,
      'price': price,
      'category':category,
      'mandatory':mandatory,
      'quantity':quantity,
      'img':img
    };
  }

  factory Additional.fromMap(Map<String, dynamic> map) {
    return Additional(
      title: map['title'],
      limit: map['limit'] ?? 0,
      category: map['category'] ?? 'Complemento',
      free:map['price'] == 0.0,
      checkBox: map['limit'] == 1,
      img: map['img'] ?? '',
      quantity: map['quantity'] ?? 0,
      mandatory: map['mandatory'] ?? false,
      description: map['description'],
     price: map['price'] != null ? map['price'] +0.0:0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Additional.fromJson(String source) => Additional.fromMap(json.decode(source));
}
