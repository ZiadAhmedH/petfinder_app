import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/pet.dart';


abstract class HomeRepository {
  Future<Either<Failure, List<Pet>>> getPetList({
    required int page,
    required int limit,
  });
}
