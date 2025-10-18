import '../../data/model/favorite_pet_model.dart';

abstract class FavoritesRepository {
  Future<List<FavoritePetModel>> getFavorites();
  Future<void> addFavorite(dynamic pet);
  Future<void> removeFavorite(String petId);
  Future<bool> isFavorite(String petId);
  Future<void> clearFavorites();
}
