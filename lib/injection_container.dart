import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:clean_tdd_flutter/features/checkDistribution/data/datasources/CheckDistributionDataSource.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/data/repositories/CheckDistributionRepositoryImpl.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/domain/repositories/CheckDistributionRepository.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/domain/usecases/GetCheckDistribution.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/presentation/bloc/Bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => CheckDistributionBloc(
      checkDistribution: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCheckDistribution(sl()));

  // Repository
  sl.registerLazySingleton<CheckDistributionRepository>(
    () => CheckDistributionRepositoryImpl(
      checkDistributionDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<CheckDistributionDataSource>(
    () => CheckDistributionDataSourceImpl(client: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
