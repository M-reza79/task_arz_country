import 'package:dartz/dartz.dart';
import 'package:task_arz_country/data/model/country_detail.dart';

abstract class ICountryDetailState {}

class CountryDetailInitialState
    extends ICountryDetailState {}

class CountryDetailLoadingState
    extends ICountryDetailState {}

class CountryDetailLoadedState
    extends ICountryDetailState { 
  final Either<String, List<CountryDetail>> borderCountries;

  CountryDetailLoadedState(this.borderCountries);
}
