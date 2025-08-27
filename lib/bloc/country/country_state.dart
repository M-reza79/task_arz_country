import 'package:dartz/dartz.dart';
import 'package:task_arz_country/data/model/countrys.dart';

abstract class CountryState {}

class InitCountry extends CountryState {}

class CountryLoadingState extends CountryState {}

class CountryResponseState extends CountryState {
  Either<String, List<Countrys>> countries;
  final List<String> continents;

  CountryResponseState(
    this.countries,
    this.continents,
  );
}
