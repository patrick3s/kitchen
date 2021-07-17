import 'dart:convert';

import 'package:multidelivery/src/domain/entities/partner.dart';
import 'package:multidelivery/src/infra/models/category.dart';
import 'package:multidelivery/src/infra/models/product.dart';

class Partner extends ResultPartner {
  final String id;
  final String name;
  final String city;
  final String uf;
  final String district;
  final String complement;
  final String street;
  final String img;
  final String backgroundImg;
  final String numberHome;
  final String reference;
  final List<String> credit;
  final List<String> debit;
  final String phoneNumber;
  final bool delivery;
  final bool isOpen;
  final String deliveryTime;
  final double deliveryPrice;
  final DateTime createAt;
  final double averange;
  final Category specialtyCategory;
  final String description;
  final List<Category> categories;
  List<Product> products;
  Partner({
     this.id,
     this.name,
     this.city,
     this.debit,
     this.credit,
     this.uf,
     this.isOpen,
     this.district,
     this.complement,
     this.street,
     this.numberHome,
     this.reference,
     this.img,
     this.deliveryPrice,
     this.backgroundImg,
     this.phoneNumber,
     this.delivery,
     this.deliveryTime,
     this.createAt,
     this.averange,
     this.specialtyCategory,
     this.description,
     this.categories,
     this.products,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'uf': uf,
      'img':img,
      'isOpen':isOpen,
      'credit':credit,
      'debit':debit,
      'backgroundImg':backgroundImg,
      'district': district,
      'complement': complement,
      'street': street,
      'numberHome': numberHome,
      'reference': reference,
      'deliveryPrice':deliveryPrice,
      'phoneNumber': phoneNumber,
      'delivery': delivery,
      'deliveryTime': deliveryTime,
      'createAt': createAt.millisecondsSinceEpoch,
      'averange': averange,
      'specialtyCategory': specialtyCategory.toMap(),
      'description': description,
      'categories': categories?.map((x) => x.toMap())?.toList(),
      'products': products?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Partner.fromMap(Map<String, dynamic> map) {
  
    return Partner(
      id: map['id'],
      name: map['name'],
      city: map['city'],
      isOpen: map['isOpen'] ?? false,
      uf: map['uf'],
      img: map['img'],
      backgroundImg: map['backgroundImg'],
      district: map['district'],
      complement: map['complement'],
      street: map['street'],
      credit: List<String>.from(map['credit'] ?? []) ,
      debit:  List<String>.from(map['debit'] ?? []) ,
      numberHome: map['numberHome'],
      reference: map['reference'],
      phoneNumber: map['phoneNumber'],
      delivery: map['delivery'],
      deliveryTime: map['deliveryTime'],
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt']),
      averange: map['averange'] + 0.0,
      specialtyCategory: Category.fromMap(map['specialtyCategory']),
      description: map['description'],
      deliveryPrice: map['deliveryPrice'] + 0.0,
      categories: List<Category>.from(map['categories']?.map((x) => Category.fromMap(x))),
      products: [],
    );
  }

  bool isNew(){
    final createAtInDays = DateTime.now().difference(createAt).inDays;
    return createAtInDays < 31;
  }

  String toJson() => json.encode(toMap());

  factory Partner.fromJson(String source) => Partner.fromMap(json.decode(source));
  }
