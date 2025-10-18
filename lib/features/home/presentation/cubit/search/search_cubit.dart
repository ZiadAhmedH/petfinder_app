import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/mapper.dart';
import '../../../domain/entities/pet.dart';
import '../../../domain/usecases/search_pet.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchPetsByNameUseCase searchPetsByNameUseCase;
  static const int _limit = 10;

  SearchCubit({required this.searchPetsByNameUseCase}) : super(SearchInitial());

  Future<void> searchPets({
    required String query,
    bool loadMore = false,
  }) async {
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    if (state is SearchLoading) return;

    int page = 0;
    List<Pet> currentPets = [];

    if (loadMore && state is SearchLoaded) {
      final loadedState = state as SearchLoaded;
      if (loadedState.hasReachedMax || loadedState.query != query) return;

      page = loadedState.currentPage + 1;
      currentPets = loadedState.pets;
      emit(SearchLoadingMore(loadedState.pets));
    } else {
      emit(SearchLoading());
    }

    final result = await searchPetsByNameUseCase(
      SearchPetsParams(query: query, page: page, limit: _limit),
    );

    result.fold(
      (failure) {
        emit(SearchError(FailureMapper.fromError(failure)));
      },
      (pets) {
        final allPets = loadMore ? [...currentPets, ...pets] : pets;
        final hasReachedMax = pets.length < _limit;

        if (allPets.isEmpty) {
          emit(SearchEmpty(query));
        } else {
          emit(
            SearchLoaded(
              pets: allPets,
              hasReachedMax: hasReachedMax,
              currentPage: page,
              query: query,
            ),
          );
        }
      },
    );
  }

  void clearSearch() {
    emit(SearchInitial());
  }
}
