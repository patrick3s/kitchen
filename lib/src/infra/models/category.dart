import 'dart:convert';

import 'package:multidelivery/src/domain/entities/category.dart';

class Category extends ResultCategory {
  final String id;
  final String title;
  final String emoji;
  final String img;
  Category({
    this.id,
    this.title,
    this.img,
   this.emoji,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'img':img,
      'title': title,
      'emoji': emoji,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      img: map['img'],
      title: map['title'],
      emoji: map['emoji'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source));
}
