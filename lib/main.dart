import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_arz_country/bloc/country/country_bloc.dart';
import 'package:task_arz_country/bloc/theme/theme_bloc.dart';
import 'package:task_arz_country/bloc/theme/theme_state.dart';
import 'package:task_arz_country/data/di/service_locator.dart';
import 'package:task_arz_country/views/home_scrennes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
              brightness: Brightness.light,
              scaffoldBackgroundColor:
                  Colors.grey[100],
              colorScheme: const ColorScheme.light(
           
                onSurface: Colors.black,
              ),
      
            ),
 
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor:
                  Colors.grey[900],
    
              colorScheme: const ColorScheme.dark(
                onSurface: Colors.white,
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
