import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_arz_country/data/di/service_locator.dart';

import 'package:task_arz_country/data/model/countrys.dart';
import 'package:task_arz_country/data/repositories/country_repository.dart';
import 'country_event.dart';
import 'country_state.dart';

class CountryBloc
    extends Bloc<CountryEvent, CountryState> {
  final ICountrysRepository _repository = locator
      .get();
  List<Countrys> _allCountries = [];

  CountryBloc() : super(InitCountry()) {
    on<LoadCountriesEvent>((event, emit) async {
      emit(CountryLoadingState());
      final responseCountry = await _repository
          .getCountriesR();
      responseCountry.fold(
        (l) => emit(
          CountryResponseState(Left(l), []),
        ),
        (countries) {
          countries.sort(
            (a, b) => a.name.compareTo(b.name),
          );
          final Set<String> uniqueContinents = {};
          for (var country in countries) {
            uniqueContinents.addAll(
              country.continents,
            );
          }
          final continentList = uniqueContinents
              .toList();
          continentList.sort();
          continentList.insert(0, 'همه');
          _allCountries = countries;

          emit(
            CountryResponseState(
              Right(countries),
              continentList,
            ),
          );
        },
      );
    });

    on<FilterCountriesByContinentEvent>((
      event,
      emit,
    ) {
      final filteredList =
          event.continent == 'همه'
          ? _allCountries
          : _allCountries
                .where(
                  (c) => c.continents.contains(
                    event.continent,
                  ),
                )
                .toList();

      if (state is CountryResponseState) {
        final currentState =
            state as CountryResponseState;
        emit(
          CountryResponseState(
            Right(filteredList),
            currentState.continents,
          ),
        );
      }
    });

    on<SearchCountryEvent>((event, emit) {
      final query = event.query.toLowerCase();

      final filteredList = _allCountries.where((
        country,
      ) {
        final countryName = country.name
            .toLowerCase();
        return countryName.startsWith(query);
      }).toList();

      if (state is CountryResponseState) {
        final currentState =
            state as CountryResponseState;
        emit(
          CountryResponseState(
            Right(filteredList),
            currentState.continents,
          ),
        );
      }
    });
  }
}
