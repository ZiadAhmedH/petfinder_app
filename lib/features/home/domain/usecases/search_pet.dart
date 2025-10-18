import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failure.dart';
import '../entities/pet.dart';
import '../repositories/home_repository.dart';

class SearchPetsByNameUseCase {
  final HomeRepository repository;

  SearchPetsByNameUseCase({required this.repository});

  Future<Either<Failure, List<Pet>>> call(SearchPetsParams params) async {
    return await repository.searchPetsByName(
      query: params.query,
      page: params.page,
      limit: params.limit,
    );
  }
}

class SearchPetsParams extends Equatable {
  final String query;
  final int page;
  final int limit;

  const SearchPetsParams({
    required this.query,
    required this.page,
    required this.limit,
  });

  @override
  List<Object> get props => [query, page, limit];
}
