import 'package:equatable/equatable.dart';
import 'package:petfinder_app_demo/core/errors/failure.dart';
import '../../../domain/entities/pet.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoadingMore extends SearchState {
  final List<Pet> currentPets;

  const SearchLoadingMore(this.currentPets);

  @override
  List<Object> get props => [currentPets];
}

class SearchLoaded extends SearchState {
  final List<Pet> pets;
  final bool hasReachedMax;
  final int currentPage;
  final String query;

  const SearchLoaded({
    required this.pets,
    this.hasReachedMax = false,
    required this.currentPage,
    required this.query,
  });

  SearchLoaded copyWith({
    List<Pet>? pets,
    bool? hasReachedMax,
    int? currentPage,
    String? query,
  }) {
    return SearchLoaded(
      pets: pets ?? this.pets,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      query: query ?? this.query,
    );
  }

  @override
  List<Object> get props => [pets, hasReachedMax, currentPage, query];
}

class SearchEmpty extends SearchState {
  final String query;

  const SearchEmpty(this.query);

  @override
  List<Object> get props => [query];
}

class SearchError extends SearchState {
  final Failure message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}
