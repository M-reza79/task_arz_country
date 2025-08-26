import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc
    extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
    : super(const ThemeState(ThemeMode.dark)) {
    // حالت اولیه: روشن
    on<ThemeToggled>((event, emit) {
      // وضعیت فعلی رو چک کن
      if (state.themeMode == ThemeMode.light) {
        // اگر روشن بود، به تاریک تغییر بده
        emit(const ThemeState(ThemeMode.dark));
      } else if (state.themeMode ==
          ThemeMode.dark) {
        // اگر تاریک بود، به روشن تغییر بده
        emit(const ThemeState(ThemeMode.light));
      }
    });
  }
}
