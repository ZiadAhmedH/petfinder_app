import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:petfinder_app_demo/core/config/app_config.dart';
import 'package:petfinder_app_demo/features/home/domain/usecases/search_pet.dart';
import 'package:petfinder_app_demo/features/home/presentation/cubit/pet/pet_cubit.dart';
import '../features/home/data/datasources/home_remote_datasource.dart';
import '../features/home/data/repositories/home_repository_impl.dart';
import '../features/home/domain/repositories/home_repository.dart';
import '../features/home/domain/usecases/get_pet_list_usecase.dart';
import '../features/home/presentation/cubit/search/search_cubit.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(() => PetCubit(getPetListUseCase: sl()));
  sl.registerFactory(() => SearchCubit(searchPetsByNameUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetPetListUseCase(repository: sl()));
  sl.registerLazySingleton(() => SearchPetsByNameUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<PetRemoteDataSource>(
    () => PetRemoteDataSourceImpl(dio: sl()),
  );

  // External - Dio with configuration
  sl.registerLazySingleton(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': AppConfig.apiKey,
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: false,
        logPrint: (obj) => print(obj),
      ),
    );

    return dio;
  });
}
