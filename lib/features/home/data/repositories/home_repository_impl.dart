import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/mapper.dart';
import '../../domain/entities/pet.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';


class HomeRepositoryImpl implements HomeRepository {
  final PetRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Pet>>> getPetList({
    required int page,
    required int limit,
  }) async {
    try {
      final petModels = await remoteDataSource.getPetList(
        page: page,
        limit: limit,
      );

      final pets = petModels.map((model) => model.toEntity()).toList();
      
      return Right(pets);
    } catch (e) {
      final failure = FailureMapper.fromError(e);
      return Left(failure);
    }
  }


  @override  Future<Either<Failure, List<Pet>>> searchPetsByName({
    required String query
    , required int page,
    required int limit,
  }) async {
    try {
      final petModels = await remoteDataSource.searchPetsByName(
        query: query,
        page: page,
        limit: limit,
      );

      final pets = petModels.map((model) => model.toEntity()).toList();
      
      return Right(pets);
    } catch (e) {
      final failure = FailureMapper.fromError(e);
      return Left(failure);
    }
  }
}
