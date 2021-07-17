
import 'dart:convert';


import 'package:multidelivery/src/domain/entities/product.dart';
import 'package:multidelivery/src/infra/models/additional.dart';
import 'package:multidelivery/src/infra/models/category.dart';
import 'package:multidelivery/src/infra/models/complement.dart';






class Product extends ResultProduct{
  final String id;
  final String name;
  final double price;
  final String img;
  final String partnerName;
  final String partnerId;
  final String partnerImg;
  final String partnerBackgroundImg;
  final List<Additional> listAdditional;
  final String description;
  final Category category;
  final bool custom;
  String comment ='';
  int quantity = 1;
  List<Complement> complements =[];
  Product({
     this.id,
     this.name,
     this.img,
     this.custom,
     this.category,
     this.complements,
     this.price,
     this.listAdditional,
     this.description,
     this.partnerBackgroundImg,
     this.partnerId,
     this.partnerImg,
     this.partnerName
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'img':img,
      'custom':custom,
      'comment':comment,
      'quantity':quantity,
      'partnerName': partnerName,
      'partnerId': partnerId,
      'partnerImg': partnerImg,
      'complements': complements?.map((x) => x?.toMap())?.toList(),
      'partnerBackgroundImg': partnerBackgroundImg,
      'listAdditional': listAdditional?.map((x) => x.toMap())?.toList(),
      'description': description,
      'category': category?.toMap(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    if(map == null) return null;
    return Product(
      id: map['id'],
      name: map['name'],
     price: map['price'] + 0.0,
      partnerName: map['partnerName'],
      partnerId: map['partnerId'],
      custom: map['custom'] ?? false,
      partnerImg: map['partnerImg'],
      img: map['img'] ?? '',
      partnerBackgroundImg: map['partnerBackgroundImg'],
      complements: map['complements'] != null ? List<Complement>.from(map['complements']?.map((x) => Complement.fromMap(x))) : [],
      listAdditional: List<Additional>.from(map['listAdditional']?.map((x) => Additional.fromMap(x))),
      description: map['description'],
      category: Category.fromMap(map['category']),
    );
  }

  double totalPrice(){
    return (complements.map((e) => e.additionals.map((e) => e.quantity * e.price).toList().fold(0, (previousValue, element) => previousValue + element)).toList().fold(0, (previousValue, element) => previousValue + element) + price) * quantity;
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));
   }
