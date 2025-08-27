import 'package:task_arz_country/data/model/country_detail.dart';
import 'package:task_arz_country/data/model/countrys.dart';

class CountryPageData {
  final CountryDetail mainCountry;
  final List<Countrys> borderCountries;

  CountryPageData({
    required this.mainCountry,
    required this.borderCountries,
  });
}
