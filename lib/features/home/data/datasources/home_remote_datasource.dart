import 'package:dio/dio.dart';
import '../../../../core/errors/mapper.dart';
import '../models/pet_model.dart';

abstract class PetRemoteDataSource {
  Future<List<PetModel>> getPetList({required int page, required int limit});
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
        'breeds', // Relative path since baseUrl is configured in Dio
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
}
