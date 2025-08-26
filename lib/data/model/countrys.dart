class Countrys {
  String name;
  List<String> capital;
  String region;
  List<String> borders;
  int population;
  String cca3;
  List<String> continents;
  String flags;
  Countrys({
    required this.name,
    required this.capital,
    required this.region,
    required this.borders,
    required this.population,
    required this.cca3,
    required this.continents,
    required this.flags,
  });


  // https://restcountries.com/v3.1/all?fields=name,capital,region,borders,population,cca3,continents,flags
  factory Countrys.fromMapJson(
    Map<String, dynamic> jsonObject,
  ) {
    return Countrys(
      name:
          jsonObject['name']['common'] ??
          'خطا name',
      capital: List<String>.from(
        jsonObject['capital'] ?? [],
      ),
      region:
          jsonObject['region'] ?? 'خطا region',
      borders: List<String>.from(
        jsonObject['borders'] ?? [],
      ),
      population:
          jsonObject['population'] ??
          'خطا region',
      cca3:
          jsonObject['cca3'] ?? 'خطا description',
      continents: List<String>.from(
        jsonObject['continents'] ?? [],
      ),
      flags:
          jsonObject['flags']['png'] ??
          'خطا description',
    );
  }
}
