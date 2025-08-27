import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_arz_country/bloc/country_detail/country_detail_event.dart';
import 'package:task_arz_country/bloc/country_detail/country_detail_state.dart';
import 'package:task_arz_country/data/di/service_locator.dart';

import 'package:task_arz_country/data/repositories/country_detail_repository.dart';

class CountryDetailBloc
    extends
        Bloc<
          ICountryDetailEvent,
          ICountryDetailState
        > {
  final ICountryDetailRepository _repository =
      locator.get();

  CountryDetailBloc()
    : super(CountryDetailInitialState()) {
    on<LoadCountryDataEvent>((event, emit) async {
      emit(CountryDetailLoadingState());
      final response = await _repository
          .getCountryPageDataR(event.countryName);

      // و پاس دادن مستقیم نتیجه به State
      emit(CountryDetailLoadedState(response));
    });
  }
}
