import 'package:hive/hive.dart';

part 'favorite_pet_model.g.dart';

@HiveType(typeId: 0)
class FavoritePetModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? imageUrl;

  @HiveField(3)
  final String? origin;

  @HiveField(4)
  final String? temperament;

  @HiveField(5)
  final String? lifeSpan;

  @HiveField(6)
  final String? weight;

  @HiveField(7)
  final DateTime addedAt;

  FavoritePetModel({
    required this.id,
    required this.name,
    this.imageUrl,
    this.origin,
    this.temperament,
    this.lifeSpan,
    this.weight,
    required this.addedAt,
  });

  // Convert from Pet entity
  factory FavoritePetModel.fromPet(dynamic pet) {
    return FavoritePetModel(
      id: pet.id,
      name: pet.name,
      imageUrl: pet.referenceImageId,
      origin: pet.origin,
      temperament: pet.temperament,
      lifeSpan: pet.lifeSpan,
      weight: pet.weight?.metric,
      addedAt: DateTime.now(),
    );
  }
}
