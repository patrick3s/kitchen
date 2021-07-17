
import 'dart:convert';

import 'package:intl/intl.dart';

import 'package:multidelivery/src/domain/entities/evaluation.dart';

class Evaluation extends ResultEvaluation {
  String id;
  String partnerId;
  DateTime createAt;
  String createAtFormat;
  String comment;
  double averange;
  String userId;
  String aswer;
  String orderId;
  String name;
  Evaluation({this.id, this.partnerId, 
  this.name,
  this.orderId,
  this.createAt, this.createAtFormat, this.comment, this.averange, this.userId, this.aswer});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId':orderId,
      'partnerId': partnerId,
      'createAt': createAt.millisecondsSinceEpoch,
      'createAtFormat': createAtFormat,
      'comment': comment,
      'averange': averange,
      'userId': userId,
      'name':name,
      'aswer': aswer,
    };
  }

  factory Evaluation.fromMap(Map<String, dynamic> map) {
    final date = DateTime.fromMillisecondsSinceEpoch(map['createAt']);
    final formatDate = new DateFormat('dd-MM-yyyy HH:mm');
    return Evaluation(
      id: map['id'],
      partnerId: map['partnerId'],
      createAt:date,
      orderId: map['orderId'],
      name: map['name'],
      createAtFormat: formatDate.format(date),
      comment: map['comment'],
      averange: map['averange'],
      userId: map['userId'],
      aswer: map['aswer'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Evaluation.fromJson(String source) => Evaluation.fromMap(json.decode(source));
}
