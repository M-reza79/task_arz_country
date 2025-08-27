import 'package:dartz/dartz.dart';
import 'package:task_arz_country/data/datasours/country_detail_data_cource.dart';
import 'package:task_arz_country/data/di/service_locator.dart';
import 'package:task_arz_country/data/model/country_page_data.dart';
import 'package:task_arz_country/util/api_exception.dart';

abstract class ICountryDetailRepository {
  Future<Either<String, CountryPageData>>
  getCountryPageDataR(String countryName);
}

class CountryDetailRepository
    extends ICountryDetailRepository {
  final ICountrysDetailDataSource _dataSource =
      locator.get();

  @override
  Future<Either<String, CountryPageData>>
  getCountryPageDataR(String countryName) async {
    try {
      final countryDetailList = await _dataSource
          .getCountryDetailD(
            countryName: countryName,
          );

      if (countryDetailList.isEmpty) {
        return left('Country not found');
      }

      final mainCountry = countryDetailList.first;
      final borderCodes = mainCountry.borders;

      final borderCountriesList =
          await _dataSource.getCountriesByCodesD(
            borderCodes,
          );

      final pageData = CountryPageData(
        mainCountry: mainCountry,
        borderCountries: borderCountriesList,
      );

      return right(pageData);
    } on ApiException catch (e) {
      return left(
        e.message ?? 'An error occurred',
      );
    } catch (e) {
      return left('An unknown error occurred');
    }
  }
}
