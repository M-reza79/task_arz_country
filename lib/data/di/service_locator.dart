import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task_arz_country/bloc/theme/theme_bloc.dart';
import 'package:task_arz_country/data/datasours/country_detail_data_cource.dart';
import 'package:task_arz_country/data/datasours/country_local_data_source.dart';
import 'package:task_arz_country/data/repositories/country_detail_repository.dart';
import 'package:task_arz_country/data/repositories/country_repository.dart';

GetIt locator = GetIt.instance;
Future<void> getItInit() async {
  locator.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl:
            'https://restcountries.com/v3.1/',
      ),
    ),
  );

  locator.registerLazySingleton<ThemeBloc>(
    () => ThemeBloc(),
  );

  // DataSource
  locator
      .registerLazySingleton<ICountrysDataSource>(
        () => CountryLocalDataSource(),
      );

  locator.registerLazySingleton<
    ICountrysDetailDataSource
  >(() => CountryDetailLocalDataSource());

  // Repository
  locator
      .registerLazySingleton<ICountrysRepository>(
        () => CountryRepository(),
      );
  locator.registerLazySingleton<
    ICountryDetailRepository
  >(() => CountryDetailRepository());
}
