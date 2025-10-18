import 'package:petfinder_app_demo/features/fav/data/model/favorite_pet_model.dart';

import '../repositories/favorites_repository.dart';

class GetFavoritesUseCase {
  final FavoritesRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<List<FavoritePetModel>> call() async {
    return await repository.getFavorites();
  }
}
