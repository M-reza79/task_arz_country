import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_arz_country/bloc/country/country_bloc.dart';
import 'package:task_arz_country/bloc/theme/theme_bloc.dart';
import 'package:task_arz_country/bloc/theme/theme_state.dart';
import 'package:task_arz_country/constants/app_colors.dart';
import 'package:task_arz_country/data/di/service_locator.dart';
import 'package:task_arz_country/views/home_scrennes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          locator.get<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'NunitoSans',
              brightness: Brightness.light,
              scaffoldBackgroundColor:
                  AppColors.veryLightGray,
              colorScheme: ColorScheme.light(
                onSurface:
                    AppColors.veryDarkBlueText,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: AppColors.white,
                iconTheme: IconThemeData(
                  color:
                      AppColors.veryDarkBlueText,
                ),
              ),
              inputDecorationTheme:
                  InputDecorationTheme(
                    fillColor: AppColors.darkGray,
                  ),
            ),
            darkTheme: ThemeData(
              fontFamily: 'NunitoSans',
              brightness: Brightness.dark,
              scaffoldBackgroundColor:
                  AppColors.veryDarkBlue,
              colorScheme: const ColorScheme.dark(
                onSurface: AppColors.wihtporange,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor:
                    AppColors.darkBlue,
                iconTheme: IconThemeData(
                  color: AppColors.wihtporange,
                ),
              ),
              inputDecorationTheme:
                  const InputDecorationTheme(
                    fillColor: AppColors.darkBlue,
                  ),
            ),
            themeMode: themeState.themeMode,
            home: BlocProvider(
              create: (context) => CountryBloc(),
              child: HomeScrennes(),
            ),
          );
        },
      ),
    );
  }
}
