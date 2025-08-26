abstract class ICountryDetailEvent {}

class LoadBorderCountriesEvent
    extends ICountryDetailEvent {
  final String countryName;
  final String continent;

  LoadBorderCountriesEvent({
    required this.countryName,
    required this.continent,
  });
}
