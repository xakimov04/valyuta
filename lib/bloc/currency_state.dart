abstract class CurrencyState {}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final List<dynamic> currencies;

  CurrencyLoaded({required this.currencies});
}

class CurrencyError extends CurrencyState {
  final String message;

  CurrencyError({required this.message});
}
