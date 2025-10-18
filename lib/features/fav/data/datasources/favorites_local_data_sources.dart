import 'package:hive/hive.dart';

import '../model/favorite_pet_model.dart';

abstract class FavoritesLocalDataSource {
  Future<List<FavoritePetModel>> getFavorites();
  Future<void> addFavorite(FavoritePetModel pet);
  Future<void> removeFavorite(String petId);
  Future<bool> isFavorite(String petId);
  Future<void> clearFavorites();
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  static const String _boxName = 'favorites';

  Future<Box<FavoritePetModel>> get _box async =>
      await Hive.openBox<FavoritePetModel>(_boxName);

  @override
  Future<List<FavoritePetModel>> getFavorites() async {
    final box = await _box;
    return box.values.toList();
  }

  @override
  Future<void> addFavorite(FavoritePetModel pet) async {
    final box = await _box;
    await box.put(pet.id, pet);
  }

  @override
  Future<void> removeFavorite(String petId) async {
    final box = await _box;
    await box.delete(petId);
  }

  @override
  Future<bool> isFavorite(String petId) async {
    final box = await _box;
    return box.containsKey(petId);
  }

  @override
  Future<void> clearFavorites() async {
    final box = await _box;
    await box.clear();
  }
}
