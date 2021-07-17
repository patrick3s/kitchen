import 'dart:convert';

import 'package:multidelivery/src/domain/entities/payment.dart';

class FormPayment extends ResultFormPayment {
  final String type;
  final String title;
  final String name;
   bool notThing;
  FormPayment({this.type, this.name,this.notThing,this.title});
  

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'title': title,
      'notThing':notThing,
      'name':name
    };
  }

  factory FormPayment.fromMap(Map<String, dynamic> map) {
    return FormPayment(
      type: map['type'],
      title: map['title'],
      notThing: map['notThing'],
      name: map['name']
    );
  }

  String toJson() => json.encode(toMap());

  factory FormPayment.fromJson(String source) => FormPayment.fromMap(json.decode(source));
}
