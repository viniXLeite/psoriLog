import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:dio/dio.dart';

import 'core/network/api_client.dart';

import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/providers/auth_provider.dart';

import 'features/daily_log/presentation/providers/daily_log_provider.dart';
import 'features/daily_log/data/repositories/mock_daily_log_repository.dart';
import 'features/daily_log/domain/repositories/daily_log_repository.dart';
import 'features/daily_log/domain/usecases/registrar_sintoma_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth
  // Provider (Factory = cria um novo sempre que precisar / ou Singleton se quiser manter estado)
  sl.registerFactory(() => AuthProvider(repository: sl()));

  // Domain (UseCases) - Use LazySingleton (sem estado, apenas lógica)
  // sl.registerLazySingleton(() => LoginUseCase(sl()));
  // Para agilizar, pulamos o UseCase!

  // Data (Repositories)
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()), // Passa DataSource e Storage
  );

  // Data (DataSources)
  sl.registerLazySingleton(
    () => AuthRemoteDataSource(sl()), // Passa ApiClient
  );
  

  //! Feature - Daily Log
  // Presentation
  sl.registerFactory(
    () => DailyLogProvider(registrarUseCase: sl()),
  );

  // Domain(UseCase)
  sl.registerLazySingleton(
    () => RegistrarSintomaUseCase(sl()),
  );

  // Data
  // Nota: Usando Mock enquanto backend não vem
  sl.registerLazySingleton<DailyLogRepository>(
    () => MockDailyLogRepository() // Usa a classe Mock específica
  );

  //! Core & External
  sl.registerLazySingleton(() => ApiClient());
  sl.registerLazySingleton(() => const FlutterSecureStorage());

}