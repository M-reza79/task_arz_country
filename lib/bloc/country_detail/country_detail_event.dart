abstract class ICountryDetailEvent {}

class LoadBorderCountriesEvent
    extends ICountryDetailEvent {
  final String countryName;

  LoadBorderCountriesEvent({
    required this.countryName,
  });
}
