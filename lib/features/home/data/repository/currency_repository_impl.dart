import 'package:currency_converter/core/networking/api_error_handler.dart';
import 'package:currency_converter/core/networking/api_result.dart';
import 'package:currency_converter/core/networking/network_info.dart';
import 'package:currency_converter/core/services/sql_helper.dart';
import 'package:currency_converter/features/home/data/data_source/api/currency_remote_data_source.dart';
import 'package:currency_converter/features/home/data/data_source/local/currency_local_data_source.dart';
import 'package:currency_converter/features/home/data/models/conversion_log_model.dart';
import 'package:currency_converter/features/home/data/models/currency_model.dart';
import 'package:currency_converter/features/home/data/models/single_currency_pair_model.dart';
import 'package:currency_converter/features/home/domain/repository/currency_repository.dart';
import 'package:flutter/foundation.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDataSource remoteDataSource;
  final CurrencyLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  List<CurrencyModel> _currencies = [];

  CurrencyRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<ApiResult<SingleCurrencyPairModel>> getSingleRate(
    String baseCurrency,
    String targetCurrency,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.fetchSinglePair(
          baseCurrency,
          targetCurrency,
        );

        await localDataSource.cacheSinglePair(remoteData);

        var model = SingleCurrencyPairModel.fromJson(remoteData);
        return ApiSuccess(model);
      } catch (e) {
        debugPrint('Error while fetching remote rate: ${e.toString()}');
        return ApiFailure(ApiErrorHandler.handle(e));
      }
    } else {
      return _fetchLocalData(baseCurrency, targetCurrency);
    }
  }

  Future<ApiResult<SingleCurrencyPairModel>> _fetchLocalData(
    String base,
    String target,
  ) async {
    try {
      final localData = await localDataSource.fetchSinglePair(base, target);
      if (localData.isNotEmpty) {
        final model = SingleCurrencyPairModel.fromJson(localData);
        return ApiSuccess(model);
      } else {
        return ApiFailure(
          ApiErrorHandler.handle(
            Exception("No internet connection and no cached data found."),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error while fetching local rate: ${e.toString()}');
      return ApiFailure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<List<CurrencyModel>>> getCurrencies() async {
    try {
      if (_currencies.isNotEmpty) return ApiSuccess(_currencies);

      if (await networkInfo.isConnected) {
        final List<dynamic> remoteRawData = await remoteDataSource
            .fetchAvailableCurrencies();
        final List<Map<String, dynamic>> castedRawData =
            List<Map<String, dynamic>>.from(remoteRawData);

        await localDataSource.cacheAvailableCurrencies(castedRawData);

        _currencies = castedRawData
            .map((json) => CurrencyModel.fromJson(json))
            .toList();

        return ApiSuccess(_currencies);
      } else {
        final List<Map<String, dynamic>> localRawData = await localDataSource
            .fetchAvailableCurrencies();
        _currencies = localRawData
            .map((json) => CurrencyModel.fromJson(json))
            .toList();

        return ApiSuccess(_currencies);
      }
    } catch (error) {
      return ApiFailure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<void> saveConversionLog(ConversionLogModel log) async {
    try {
      await SQLHelper.insert(log.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
