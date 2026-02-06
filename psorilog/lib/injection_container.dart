import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:dio/dio.dart';

import 'core/network/api_client.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/daily_log/domain/repositories/daily_log_repository.dart';
import 'features/daily_log/data/repositories/mock_daily_log_repository.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/providers/auth_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth
  // Provider (Factory = cria um novo sempre que precisar / ou Singleton se quiser manter estado)
  sl.registerFactory(() => AuthProvider(repository: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()), // Passa DataSource e Storage
  );

  // Para DailyLog (que vamos criar do zero):
  sl.registerLazySingleton<DailyLogRepository>(
      () => MockDailyLogRepository() // Usa a classe Mock específica
  );

  // Data Sources
  sl.registerLazySingleton(
    () => AuthRemoteDataSource(sl()), // Passa ApiClient
  );

  //! Core & External
  sl.registerLazySingleton(() => ApiClient());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
}