import 'package:dio/dio.dart';
import '../../../../core/errors/mapper.dart';
import '../models/pet_model.dart';

abstract class PetRemoteDataSource {
  Future<List<PetModel>> getPetList({required int page, required int limit});
  Future<List<PetModel>> searchPetsByName({
    required String query,
    required int page,
    required int limit,
  });
}

class PetRemoteDataSourceImpl implements PetRemoteDataSource {
  final Dio dio;

  PetRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PetModel>> getPetList({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dio.get(
        'breeds',
        queryParameters: {'limit': limit, 'page': page},
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map<PetModel>((json) => PetModel.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Failed to load pets',
        );
      }
    } catch (e) {
      final failure = FailureMapper.fromError(e);
      throw failure;
    }
  }

  @override
  Future<List<PetModel>> searchPetsByName({
    required String query,
    required int page,
    required int limit,
  }) async {
    try {
      // Use the breeds/search endpoint which supports 'q' parameter
      final response = await dio.get(
        'breeds/search',
        queryParameters: {'q': query},
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> data = response.data as List<dynamic>;

        // Apply pagination on client side
        final startIndex = page * limit;
        final endIndex = startIndex + limit;

        final paginatedData = data.skip(startIndex).take(limit).toList();

        return paginatedData
            .map<PetModel>((json) => PetModel.fromJson(json))
            .toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Failed to search pets',
        );
      }
    } catch (e) {
      final failure = FailureMapper.fromError(e);
      throw failure;
    }
  }
}
