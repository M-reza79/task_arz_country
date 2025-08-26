import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc
    extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
    : super(const ThemeState(ThemeMode.dark)) {
    on<ThemeToggled>((event, emit) {
      if (state.themeMode == ThemeMode.light) {
        emit(const ThemeState(ThemeMode.dark));
      } else if (state.themeMode ==
          ThemeMode.dark) {
        emit(const ThemeState(ThemeMode.light));
      }
    });
  }
}
