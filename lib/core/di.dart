import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:petfinder_app_demo/core/config/app_config.dart';

// 🐾 Home Feature
import 'package:petfinder_app_demo/features/home/data/datasources/home_remote_datasource.dart';
import 'package:petfinder_app_demo/features/home/data/repositories/home_repository_impl.dart';
import 'package:petfinder_app_demo/features/home/domain/repositories/home_repository.dart';
import 'package:petfinder_app_demo/features/home/domain/usecases/get_pet_list_usecase.dart';
import 'package:petfinder_app_demo/features/home/domain/usecases/search_pet.dart';
import 'package:petfinder_app_demo/features/home/presentation/cubit/pet/pet_cubit.dart';
import 'package:petfinder_app_demo/features/home/presentation/cubit/search/search_cubit.dart';

// ❤️ Favorites Feature
import 'package:petfinder_app_demo/features/fav/data/datasources/favorites_local_data_sources.dart';
import 'package:petfinder_app_demo/features/fav/data/repositories/favorites_repository_impl.dart';
import 'package:petfinder_app_demo/features/fav/domain/repositories/favorites_repository.dart';
import 'package:petfinder_app_demo/features/fav/domain/usecases/get_favorites_usecase.dart';
import 'package:petfinder_app_demo/features/fav/domain/usecases/toggle_favorite_usecase.dart';
import 'package:petfinder_app_demo/features/fav/presentation/cubit/favorites_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ---------------------------------------------------------------------------
  // 🧠 CUBITS (Presentation Layer)
  // ---------------------------------------------------------------------------
  sl.registerFactory(() => PetCubit(getPetListUseCase: sl()));
  sl.registerFactory(() => SearchCubit(searchPetsByNameUseCase: sl()));
  sl.registerFactory(
    () => FavoritesCubit(
      getFavoritesUseCase: sl(),
      toggleFavoriteUseCase: sl(),
    ),
  );

  // ---------------------------------------------------------------------------
  // ⚙️ USE CASES (Domain Layer)
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton(() => GetPetListUseCase(repository: sl()));
  sl.registerLazySingleton(() => SearchPetsByNameUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetFavoritesUseCase(sl()));
  sl.registerLazySingleton(() => ToggleFavoriteUseCase(sl()));

  // ---------------------------------------------------------------------------
  // 🧩 REPOSITORIES (Data Layer)
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(localDataSource: sl()),
  );

  // ---------------------------------------------------------------------------
  // 📡 DATA SOURCES
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<PetRemoteDataSource>(
    () => PetRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSourceImpl(),
  );

  // ---------------------------------------------------------------------------
  // 🌐 EXTERNAL DEPENDENCIES (e.g., Dio)
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<Dio>(() {
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
