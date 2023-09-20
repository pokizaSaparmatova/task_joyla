import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task/core/network/network_info.dart';
import 'package:task/data/dataSourse/base_api.dart';
import 'package:task/data/dataSourse/remote_datasource.dart';
import 'package:task/data/repository/repository_impl.dart';
import 'package:task/domain/repository/repository.dart';
import 'package:task/domain/useCase/usecase_impl.dart';
import 'package:task/presentation/bloc/home_bloc.dart';

final di = GetIt.instance;

Future<void> setUp() async {
  di.registerSingleton(BaseApi(Dio(BaseOptions(
      baseUrl: "https://mobile-api.joyla.uz/mobile/",
      connectTimeout: const Duration(seconds: 60)))));

  // di.registerSingleton(() => HomeApi(di.get()));

  di.registerFactory(() => HomeApi(di.get()));

//BloC
  di.registerFactory(() => HomeBloc(di.get()));

//UseCase
  di.registerLazySingleton(() => JoylaUsecase(di.get<JoylaRepository>()));

  // Repository
  di.registerLazySingleton<JoylaRepository>(
      () => JoylaRepositoryImpl(di.get<HomeApi>(), di.get<NetworkInfo>()));

  // Core
  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(
        di.get(),
      ));
  di.registerLazySingleton(() => InternetConnectionChecker());
}
