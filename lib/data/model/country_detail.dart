class CountryDetail {
  String name;
  String nativeName;
  int population;
  String region;
  String subregion;
  List<String> capital;
  List<String> tld;
  String currencies;
  List<String> languages;
  List<String> borders;
  String cca3;
  List<String> continents;
  String flags;
  CountryDetail({
    required this.name,
    required this.nativeName,
    required this.population,
    required this.region,
    required this.subregion,
    required this.capital,
    required this.tld,
    required this.currencies,
    required this.languages,
    required this.borders,
    required this.cca3,
    required this.continents,
    required this.flags,
  });

  factory CountryDetail.fromMapJson(
    Map<String, dynamic> jsonObject,
  ) {
    String getNativeName(
      Map<String, dynamic> nameData,
    ) {
      if (nameData['nativeName'] != null &&
          (nameData['nativeName'] as Map)
              .isNotEmpty) {
        return nameData['nativeName']
                .values
                .first['common'] ??
            'Not Available';
      }
      return nameData['common'] ??
          'Not Available';
    }

    String getCurrencyNames(
      Map<String, dynamic>? currencyData,
    ) {
      if (currencyData == null ||
          currencyData.isEmpty) {
        return 'Not Available';
      }

      return currencyData.values
          .map((c) => c['name'] as String)
          .join(', ');
    }

    List<String> getLanguageNames(
      Map<String, dynamic>? languageData,
    ) {
      if (languageData == null ||
          languageData.isEmpty) {
        return [];
      }
      return languageData.values
          .cast<String>()
          .toList();
    }

    return CountryDetail(
      name:
          jsonObject['name']?['common'] ??
          'Not Available',
      
      nativeName: getNativeName(
        jsonObject['name'],
      ),
       
      population: jsonObject['population'] ?? 0,
      region:
          jsonObject['region'] ?? 'Not Available',
      subregion:
          jsonObject['subregion'] ??
          'Not Available',
      capital: List<String>.from(
        jsonObject['capital'] ?? [],
      ),
 
      tld: List<String>.from(
        jsonObject['tld'] ?? [],
      ),
       
      currencies: getCurrencyNames(
        jsonObject['currencies'],
      ),
      languages: getLanguageNames(
        jsonObject['languages'],
      ),
      borders: List<String>.from(
        jsonObject['borders'] ?? [],
      ),
      cca3: jsonObject['cca3'] ?? '',
      continents: List<String>.from(
        jsonObject['continents'] ?? [],
      ),
      flags: jsonObject['flags']?['png'] ?? '',
    );
  }
}
