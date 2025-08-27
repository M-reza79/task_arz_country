abstract class ICountryDetailEvent {}

class LoadCountryDataEvent 
    extends ICountryDetailEvent {
  final String countryName;
  LoadCountryDataEvent (this.countryName);
}
