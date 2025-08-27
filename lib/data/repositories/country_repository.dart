import 'package:dartz/dartz.dart';
import 'package:task_arz_country/data/datasours/country_local_data_source.dart';
import 'package:task_arz_country/data/di/service_locator.dart';
import 'package:task_arz_country/data/model/countrys.dart';
import 'package:task_arz_country/util/api_exception.dart';

abstract class ICountrysRepository {
  Future<Either<String, List<Countrys>>>
  getCountriesR();
}

class CountryRepository
    extends ICountrysRepository {
  final ICountrysDataSource _dataSource = locator
      .get();

  @override
  Future<Either<String, List<Countrys>>>
  getCountriesR() async {
    try {
      var responseCountry = await _dataSource
          .getCountriesD();
      return right(responseCountry);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا');
    }
  }
}
