import 'package:dartz/dartz.dart';
import 'package:task_arz_country/data/datasours/country_detail_data_cource.dart';

import 'package:task_arz_country/data/di/service_locator.dart';
import 'package:task_arz_country/data/model/country_detail.dart';

import 'package:task_arz_country/util/api_exception.dart';

abstract class ICountryDetailRepository {
  Future<Either<String, List<CountryDetail>>>
  getCountryDetailR({
    required String countryName,
    required String continent,
  });
}

class CountryDetailRepository
    extends ICountryDetailRepository {
  final ICountrysDetailDataSource _dataSource =
      locator.get();

  @override
  Future<Either<String, List<CountryDetail>>>
  getCountryDetailR({
    required String countryName,
    required String continent,
  }) async {
    try {
      var responseCountry = await _dataSource
          .getCountryDetailD(
            countryName: countryName,
            continent: continent,
          );
      return right(responseCountry);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا');
    }
  }
}
