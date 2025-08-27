abstract class CountryEvent {}

class LoadCountriesEvent extends CountryEvent {}

class FilterCountriesByContinentEvent
    extends CountryEvent {
  final String continent;

  FilterCountriesByContinentEvent(this.continent);
}

class SearchCountryEvent extends CountryEvent {
  final String query;

  SearchCountryEvent(this.query);
}
