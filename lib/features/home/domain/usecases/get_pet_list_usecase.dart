import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../entities/pet.dart';
import '../repositories/home_repository.dart';

class GetPetListUseCase {
  final HomeRepository repository;

  GetPetListUseCase({required this.repository});

  Future<Either<Failure, List<Pet>>> call(GetPetListParams params) async {
    return await repository.getPetList(page: params.page, limit: params.limit);
  }
}

class GetPetListParams extends Equatable {
  final int page;
  final int limit;

  const GetPetListParams({required this.page, required this.limit});

  @override
  List<Object> get props => [page, limit];
}
