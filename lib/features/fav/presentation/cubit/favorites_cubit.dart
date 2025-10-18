import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_favorites_usecase.dart';
import '../../domain/usecases/toggle_favorite_usecase.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  // Track individual pet favorite status
  final Map<String, bool> _favoriteStatus = {};

  FavoritesCubit({
    required this.getFavoritesUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(FavoritesInitial());

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());

    try {
      final favorites = await getFavoritesUseCase();

      // Update favorite status map
      _favoriteStatus.clear();
      for (var fav in favorites) {
        _favoriteStatus[fav.id] = true;
      }

      if (favorites.isEmpty) {
        emit(FavoritesEmpty());
      } else {
        emit(FavoritesLoaded(favorites));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> toggleFavorite(dynamic pet) async {
    try {
      final isFavorite = await toggleFavoriteUseCase(pet);
      _favoriteStatus[pet.id] = isFavorite;

      // Reload favorites to update UI
      await loadFavorites();
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  bool isFavorite(String petId) {
    return _favoriteStatus[petId] ?? false;
  }
}
