

import 'package:multidelivery/src/domain/entities/additional.dart';
import 'package:multidelivery/src/domain/entities/category.dart';
import 'package:multidelivery/src/infra/models/complement.dart';

class ResultProduct {
  final String id;
  final String name;
  final double price;
  final String partnerName;
  final String partnerId;
  final String partnerImg;
  final bool custom;
  final String partnerBackgroundImg;
  final List<ResultAdditional> listAdditional;
  final String description;
  final String img;
  final ResultCategory category;
  List<Complement> complements =[];
  ResultProduct({
     this.id,
     this.name,
     this.category,
     this.img,
     this.price,
     this.custom,
     this.listAdditional,
     this.description,
     this.partnerBackgroundImg,
     this.partnerId,
     this.partnerImg,
     this.partnerName
  });
   }
