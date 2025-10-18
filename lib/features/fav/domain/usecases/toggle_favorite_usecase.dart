import '../repositories/favorites_repository.dart';

class ToggleFavoriteUseCase {
  final FavoritesRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<bool> call(dynamic pet) async {
    final isFav = await repository.isFavorite(pet.id);

    if (isFav) {
      await repository.removeFavorite(pet.id);
      return false;
    } else {
      await repository.addFavorite(pet);
      return true;
    }
  }
}
