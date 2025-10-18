import 'package:petfinder_app_demo/features/fav/domain/repositories/favorites_repository.dart';
import 'package:petfinder_app_demo/features/fav/data/datasources/favorites_local_data_sources.dart';
import 'package:petfinder_app_demo/features/fav/data/model/favorite_pet_model.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl({required this.localDataSource});

  @override
  Future<List<FavoritePetModel>> getFavorites() async {
    return await localDataSource.getFavorites();
  }

  @override
  Future<void> addFavorite(dynamic pet) async {
    final favoritePet = FavoritePetModel.fromPet(pet);
    await localDataSource.addFavorite(favoritePet);
  }

  @override
  Future<void> removeFavorite(String petId) async {
    await localDataSource.removeFavorite(petId);
  }

  @override
  Future<bool> isFavorite(String petId) async {
    return await localDataSource.isFavorite(petId);
  }

  @override
  Future<void> clearFavorites() async {
    await localDataSource.clearFavorites();
  }
}
