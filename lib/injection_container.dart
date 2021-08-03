import 'package:clean_tdd_flutter/core/injection/register_module.dart';
import 'package:clean_tdd_flutter/features/login/data/datasources/LoginDataSource.dart';
import 'package:clean_tdd_flutter/features/login/data/repositories/LoginRepositoryImpl.dart';
import 'package:clean_tdd_flutter/features/login/domain/repositories/LoginRepository.dart';
import 'package:clean_tdd_flutter/features/login/domain/usecases/GetLogin.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:clean_tdd_flutter/features/checkDistribution/data/datasources/CheckDistributionDataSource.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/data/repositories/CheckDistributionRepositoryImpl.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/domain/repositories/CheckDistributionRepository.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/domain/usecases/GetCheckDistribution.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/presentation/bloc/Bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/login/presentation/bloc/Bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => CheckDistributionBloc(
      checkDistribution: sl(),
    ),
  );
  sl.registerFactory(
    () => LoginBloc(
      login: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCheckDistribution(sl()));
  sl.registerLazySingleton(() => GetLogin(sl()));

  // Repository
  sl.registerLazySingleton<CheckDistributionRepository>(
    () => CheckDistributionRepositoryImpl(
      checkDistributionDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      loginDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<CheckDistributionDataSource>(
    () => CheckDistributionDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<LoginDataSource>(
    () => LoginDataSourceImpl(client: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());

  //! Graphql
  final registerModule = _$RegisterModule();
  sl.registerLazySingleton<GraphQLClient>(() => registerModule.gqlClient);
}

class _$RegisterModule extends RegisterModule {}
