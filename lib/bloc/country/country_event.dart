abstract class CountryEvent {}

// فقط یک Event داریم برای لود کشورها
class LoadCountriesEvent extends CountryEvent {}

class FilterCountriesByContinentEvent
    extends CountryEvent {
  final String continent;

  FilterCountriesByContinentEvent(this.continent);
}

// country_event.dart

class SearchCountryEvent extends CountryEvent {
  final String query; // متنی که کاربر تایپ کرده

  SearchCountryEvent(this.query);
}