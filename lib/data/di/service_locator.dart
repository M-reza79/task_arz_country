import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task_arz_country/bloc/theme/theme_bloc.dart';
import 'package:task_arz_country/data/datasours/country_local_data_source.dart';
import 'package:task_arz_country/data/repositories/country_repository.dart';

GetIt locator = GetIt.instance;
Future<void> getItInit() async {
  locator.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: 'https://restcountries.com/v3.1/',
      ),
    ),
  );

  locator.registerLazySingleton<ThemeBloc>(
    () => ThemeBloc(),
  );

 
  // DataSource
  locator.registerLazySingleton<
    ICountrysDataSource
  >(() => CountryLocalDataSource());

  // Repository
  locator
      .registerLazySingleton<ICountrysRepository>(
        () => CountryRepository(),
      );
}
