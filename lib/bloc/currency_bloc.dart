import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/currency_service.dart';
import 'currency_event.dart';
import 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyService currencyService;

  CurrencyBloc({required this.currencyService}) : super(CurrencyInitial()) {
    on<FetchCurrencies>((event, emit) async {
      emit(CurrencyLoading());
      try {
        final currencies = await currencyService.fetchCurrencies();
        emit(CurrencyLoaded(currencies: currencies));
      } catch (e) {
        emit(CurrencyError(message: e.toString()));
      }
    });
  }
}
