// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:hive/hive.dart';

part 'Gaz.g.dart';

@HiveType(typeId: 1)
class Gaz {
  @HiveField(0)
  final image;

  @HiveField(1)
  final size;

  @HiveField(2)
  final String quantity;

  @HiveField(3)
  final int price;

  Gaz(
      {required this.image,
      this.size,
      required this.quantity,
      required this.price});
}
