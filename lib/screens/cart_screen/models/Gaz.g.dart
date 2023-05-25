// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Gaz.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GazAdapter extends TypeAdapter<Gaz> {
  @override
  final int typeId = 1;

  @override
  Gaz read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Gaz(
      image: fields[0] as dynamic,
      size: fields[1] as dynamic,
      quantity: fields[2] as String,
      price: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Gaz obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.size)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GazAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
