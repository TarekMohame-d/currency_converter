import 'package:currency_converter/core/networking/api_error_model.dart';
import 'package:currency_converter/features/home/data/models/currency_model.dart';
import 'package:currency_converter/features/home/data/models/single_currency_pair_model.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class CurrencyState {}

final class CurrencyInitial extends CurrencyState {}

final class GetSingleCurrencyRateLoading extends CurrencyState {}

final class GetSingleCurrencyRateSuccess extends CurrencyState {
  final SingleCurrencyPairModel currencyPairModel;

  GetSingleCurrencyRateSuccess(this.currencyPairModel);
}

final class GetSingleCurrencyRateFailure extends CurrencyState {
  final ApiErrorModel errorModel;

  GetSingleCurrencyRateFailure(this.errorModel);
}

final class CurrencyListLoading extends CurrencyState {}

final class CurrencyListSuccess extends CurrencyState {
  final List<CurrencyModel> currencies;

  CurrencyListSuccess(this.currencies);
}

final class CurrencyListFailure extends CurrencyState {
  final ApiErrorModel errorModel;

  CurrencyListFailure(this.errorModel);
}
