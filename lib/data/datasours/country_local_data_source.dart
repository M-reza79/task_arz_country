import 'package:dio/dio.dart';

import 'package:task_arz_country/data/di/service_locator.dart';

import 'package:task_arz_country/data/model/countrys.dart';
import 'package:task_arz_country/util/api_exception.dart';

abstract class ICountrysDataSource {
  Future<List<Countrys>> getCountriesD();
}

class CountryLocalDataSource
    extends ICountrysDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<Countrys>> getCountriesD() async {
    try {
      var response = await _dio.get(
        'all?fields=name,capital,region,borders,population,cca3,continents,flags',
      );

      return response.data
          .map<Countrys>(
            (jsonObject) =>
                Countrys.fromMapJson(jsonObject),
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
}
