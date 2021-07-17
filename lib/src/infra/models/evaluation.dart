
import 'dart:convert';

import 'package:intl/intl.dart';

import 'package:multidelivery/src/domain/entities/evaluation.dart';

class Evaluation extends ResultEvaluation {
  final String id;
  final String partnerId;
  final DateTime createAt;
  final String createAtFormat;
  final String comment;
  final double averange;
  final String userId;
  final String aswer;
  final String name;
  Evaluation({this.id, this.partnerId, 
  this.name,
  this.createAt, this.createAtFormat, this.comment, this.averange, this.userId, this.aswer});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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
