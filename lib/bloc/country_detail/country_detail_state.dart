import 'package:dartz/dartz.dart';
import 'package:task_arz_country/data/model/country_detail.dart';
import 'package:task_arz_country/data/model/country_page_data.dart';

abstract class ICountryDetailState {}

class CountryDetailInitialState
    extends ICountryDetailState {}

class CountryDetailLoadingState
    extends ICountryDetailState {}

class CountryDetailLoadedState
    extends ICountryDetailState { 
final Either<String, CountryPageData> countryPageData;
  CountryDetailLoadedState(this.countryPageData);
}
