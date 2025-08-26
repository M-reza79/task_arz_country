// class Country {
//   String name;
//   String continent;
//   String capital;
//   String flag;
//   List<String> borders;
//   String description;
//   Country({
//     required this.name,
//     required this.continent,
//     required this.capital,
//     required this.flag,
//     required this.borders,
//     required this.description,
//   });

//   factory Country.fromJson(
//     Map<String, dynamic> jsonObject,
//   ) {
//     return Country(
//       name: jsonObject['name'] ?? 'خطا name',
//       continent:
//           jsonObject['continent'] ??
//           'خطا continent',
//       capital:
//           jsonObject['capital'] ??
//           'خطا capital',
//       flag: jsonObject['flag'] ?? 'خطا flag',
//       borders: List<String>.from(
//         jsonObject['borders'] ?? [],
//       ),
//       description:
//           jsonObject['description'] ??
//           'خطا description',
//     );
//   }
// }
