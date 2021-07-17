import 'dart:convert';


import 'package:multidelivery/src/infra/models/additional.dart';

class Complement {
  final String title;
  final bool mandatory;
  final int limit;
  final List<Additional> additionals;
  final List<Additional> selected ;
  int quantity = 0;
  Complement(this.title, this.mandatory, this.limit,this.selected,this.additionals);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'mandatory': mandatory,
      'selected':selected?.map((e) => e?.toMap())?.toList(),
      'limit':limit,
      'additionals': additionals?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Complement.fromMap(Map<String, dynamic> map) {
    return Complement(
      map['title'],
      map['mandatory'],
      map['limit'],
       List<Additional>.from(map['selected']?.map((x) => Additional.fromMap(x))),
      List<Additional>.from(map['additionals']?.map((x) => Additional.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Complement.fromJson(String source) => Complement.fromMap(json.decode(source));
}
