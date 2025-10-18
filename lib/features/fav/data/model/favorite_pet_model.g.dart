// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_pet_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoritePetModelAdapter extends TypeAdapter<FavoritePetModel> {
  @override
  final int typeId = 0;

  @override
  FavoritePetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoritePetModel(
      id: fields[0] as String,
      name: fields[1] as String,
      imageUrl: fields[2] as String?,
      origin: fields[3] as String?,
      temperament: fields[4] as String?,
      lifeSpan: fields[5] as String?,
      weight: fields[6] as String?,
      addedAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FavoritePetModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.origin)
      ..writeByte(4)
      ..write(obj.temperament)
      ..writeByte(5)
      ..write(obj.lifeSpan)
      ..writeByte(6)
      ..write(obj.weight)
      ..writeByte(7)
      ..write(obj.addedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritePetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
