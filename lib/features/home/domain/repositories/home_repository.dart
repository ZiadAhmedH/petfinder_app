import 'package:dartz/dartz.dart';
import 'package:petfinder_app_demo/core/errors/failure.dart';
import '../entities/pet.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Pet>>> getPetList({
    required int page,
    required int limit,
  });

  Future<Either<Failure, List<Pet>>> searchPetsByName({
    required String query,
    required int page,
    required int limit,
  });
}
