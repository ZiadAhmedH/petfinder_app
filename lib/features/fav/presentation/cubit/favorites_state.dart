import 'package:equatable/equatable.dart';

import '../../data/model/favorite_pet_model.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<FavoritePetModel> favorites;

  const FavoritesLoaded(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

class FavoritesEmpty extends FavoritesState {}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}

// For individual pet favorite status
class FavoriteStatusState extends Equatable {
  final Map<String, bool> favoriteStatus;

  const FavoriteStatusState(this.favoriteStatus);

  @override
  List<Object?> get props => [favoriteStatus];
}
