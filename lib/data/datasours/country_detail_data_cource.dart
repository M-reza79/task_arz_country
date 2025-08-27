import 'package:dio/dio.dart';

import 'package:task_arz_country/data/di/service_locator.dart';
import 'package:task_arz_country/data/model/country_detail.dart';
import 'package:task_arz_country/data/model/countrys.dart';

import 'package:task_arz_country/util/api_exception.dart';

abstract class ICountrysDetailDataSource {
  Future<List<CountryDetail>> getCountryDetailD({
    required String countryName,
  });
  Future<List<Countrys>> getCountriesByCodesD(
    List<String> codes,
  );
}

class CountryDetailLocalDataSource
    extends ICountrysDetailDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<CountryDetail>> getCountryDetailD({
    required String countryName,
  }) async {
    try {
      final response = await _dio.get(
        'name/$countryName',
      );

      return response.data
          .map<CountryDetail>(
            (jsonObject) =>
                CountryDetail.fromMapJson(
                  jsonObject,
                ),
          )
          .toList();
    } on DioException catch (ex) {
      throw ApiException(
        ex.response?.statusCode,
        ex.response?.data['message'],
      );
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<List<Countrys>> getCountriesByCodesD(
    List<String> codes,
  ) async {
    try {
        if (codes.isEmpty) {
      return []; // برگرداندن لیست خالی اگر کدی وجود نداشته باشد
    }
    final response = await _dio.get('https://restcountries.com/v3.1/alpha?codes=${codes.join(',')}');
    List<Countrys> countries = (response.data as List)
        .map((json) => Countrys.fromMapJson(json))
        .toList();
    return countries;
 
       
    }on DioException catch (ex) {
      throw ApiException(
        ex.response?.statusCode,
        ex.response?.data['message'],
      );
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }
}
