// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:hive/hive.dart';

part 'Gaz.g.dart';

@HiveType(typeId: 1)
class Gaz {
  @HiveField(0)
  final String image;

  @HiveField(1)
  final String size;

  @HiveField(2)
  final String quantity;

  @HiveField(3)
  final int price;

  Gaz(
      {required this.image,
      required this.size,
      required this.quantity,
      required this.price});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'size': size,
      'quantity': quantity,
      'price': price,
    };
  }

  factory Gaz.fromMap(Map<String, dynamic> map) {
    return Gaz(
      image: map['image'] as String,
      size: map['size'] as String,
      quantity: map['quantity'] as String,
      price: map['price'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Gaz.fromJson(String source) =>
      Gaz.fromMap(json.decode(source) as Map<String, dynamic>);
}
