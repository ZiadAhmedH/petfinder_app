import 'package:bloc/bloc.dart';

import '../../../../../core/errors/mapper.dart';
import '../../../domain/usecases/get_pet_list_usecase.dart';
import '../../../domain/entities/pet.dart';
import 'pet_state.dart';

class PetCubit extends Cubit<PetState> {
  final GetPetListUseCase getPetListUseCase;
  static const int _limit = 10;

  PetCubit({required this.getPetListUseCase}) : super(PetInitial());

  int _currentPage = 0;
  List<Pet> _allPets = [];
  bool _hasReachedMax = false;
  bool _isLoading = false;

  Future<void> loadPets() async {
    if (_isLoading || _hasReachedMax) return;
    
    _isLoading = true;

    // First load
    if (_currentPage == 0) {
      emit(PetLoading());
    } else {
      // Load more
      emit(PetsLoadingMore(_allPets));
    }

    final result = await getPetListUseCase(
      GetPetListParams(page: _currentPage, limit: _limit),
    );

    result.fold(
      (failure) {
        _isLoading = false;
        emit(PetsError(FailureMapper.fromError(failure)));
      },
      (pets) {
        _currentPage++;
        _allPets.addAll(pets);
        _hasReachedMax = pets.length < _limit;
        _isLoading = false;

        emit(PetsLoaded(
          pets: _allPets,
          hasReachedMax: _hasReachedMax,
        ));
      },
    );
  }

  void refresh() {
    _currentPage = 0;
    _allPets = [];
    _hasReachedMax = false;
    _isLoading = false;
    loadPets();
  }
}