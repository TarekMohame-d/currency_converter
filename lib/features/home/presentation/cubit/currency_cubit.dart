import 'package:currency_converter/core/networking/api_result.dart';
import 'package:currency_converter/features/home/data/models/conversion_log_model.dart';
import 'package:currency_converter/features/home/data/models/currency_model.dart';
import 'package:currency_converter/features/home/data/models/single_currency_pair_model.dart';
import 'package:currency_converter/features/home/domain/usecases/get_currencies_use_case.dart';
import 'package:currency_converter/features/home/domain/usecases/get_exchange_rates_use_case.dart';
import 'package:currency_converter/features/home/domain/usecases/save_conversion_record_use_case.dart';
import 'package:currency_converter/features/home/presentation/cubit/currency_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  final GetExchangeRatesUseCase getExchangeRatesUseCase;
  final GetCurrenciesUseCase getCurrenciesUseCase;
  final SaveConversionLogUseCase saveConversionLogUseCase;

  CurrencyCubit(
    this.getExchangeRatesUseCase,
    this.getCurrenciesUseCase,
    this.saveConversionLogUseCase,
  ) : super(CurrencyInitial());

  Future<void> getExchangeRates(
    String baseCurrency,
    String targetCurrency,
  ) async {
    emit(GetSingleCurrencyRateLoading());
    final result = await getExchangeRatesUseCase.call(
      baseCurrency,
      targetCurrency,
    );

    if (result is ApiSuccess<SingleCurrencyPairModel>) {
      emit(GetSingleCurrencyRateSuccess(result.data));
    } else if (result is ApiFailure<SingleCurrencyPairModel>) {
      emit(GetSingleCurrencyRateFailure(result.error));
    }
  }

  void swapCurrencies() {
    if (state is GetSingleCurrencyRateSuccess) {
      final currentModel =
          (state as GetSingleCurrencyRateSuccess).currencyPairModel;

      final double invertedRate = currentModel.rate != 0
          ? 1.0 / currentModel.rate
          : 0.0;

      final swappedModel = SingleCurrencyPairModel(
        base: currentModel.quote,
        quote: currentModel.base,
        date: currentModel.date,
        rate: invertedRate,
      );

      emit(GetSingleCurrencyRateSuccess(swappedModel));
    }
  }

  Future<void> getCurrencies() async {
    emit(CurrencyListLoading());
    final result = await getCurrenciesUseCase.call();

    if (result is ApiSuccess<List<CurrencyModel>>) {
      emit(CurrencyListSuccess(result.data));
    } else if (result is ApiFailure<List<CurrencyModel>>) {
      emit(CurrencyListFailure(result.error));
    }
  }

  Future<void> logConversionToDatabase({
    required String base,
    required String quote,
    required double rate,
    required double amount,
  }) async {
    try {
      final logItem = ConversionLogModel(
        date: DateTime.now().toString().split(' ')[0],
        base: base,
        quote: quote,
        rate: rate,
        amount: amount,
      );

      await saveConversionLogUseCase(logItem);
    } catch (e) {}
  }
}
