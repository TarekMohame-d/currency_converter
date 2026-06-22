import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:currency_converter/core/networking/dio_factory.dart';
import 'package:currency_converter/core/networking/network_info.dart';
import 'package:currency_converter/features/history/data/data_source/history_currency_data_source_impl.dart';
import 'package:currency_converter/features/history/data/data_source/interfaces/history_currency_data_source.dart';
import 'package:currency_converter/features/history/data/repository/history_repository_impl.dart';
import 'package:currency_converter/features/history/domain/repository/history_repository.dart';
import 'package:currency_converter/features/history/domain/usecases/clear_conversion_history_use_case.dart';
import 'package:currency_converter/features/history/domain/usecases/delete_currency_conversion_item_use_case.dart';
import 'package:currency_converter/features/history/domain/usecases/get_currency_history_use_case.dart';
import 'package:currency_converter/features/home/data/data_source/api/currency_remote_data_source.dart';
import 'package:currency_converter/features/home/data/data_source/local/currency_local_data_source.dart';
import 'package:currency_converter/features/home/data/repository/currency_repository_impl.dart';
import 'package:currency_converter/features/home/domain/repository/currency_repository.dart';
import 'package:currency_converter/features/home/domain/usecases/get_currencies_use_case.dart';
import 'package:currency_converter/features/home/domain/usecases/get_exchange_rates_use_case.dart';
import 'package:currency_converter/features/home/domain/usecases/save_conversion_record_use_case.dart';
import 'package:currency_converter/features/settings/data/repository/settings_repository_impl.dart';
import 'package:currency_converter/features/settings/domain/repository/settings_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
Future<void> setupGetIt() async {
  getIt.registerLazySingleton<Dio>(() => DioFactory.dio);

  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<Connectivity>()),
  );

  getIt.registerLazySingleton<CurrencyRemoteDataSource>(
    () => CurrencyRemoteDataSource(getIt<Dio>()),
  );
  getIt.registerLazySingleton<CurrencyLocalDataSource>(
    () => CurrencyLocalDataSource(),
  );

  getIt.registerLazySingleton<CurrencyRepository>(
    () => CurrencyRepositoryImpl(
      remoteDataSource: getIt<CurrencyRemoteDataSource>(),
      localDataSource: getIt<CurrencyLocalDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  getIt.registerLazySingleton<HistoryCurrencyDataSource>(
    () => HistoryCurrencyDataSourceImpl(),
  );

  getIt.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(getIt<HistoryCurrencyDataSource>()),
  );

  getIt.registerLazySingleton<GetExchangeRatesUseCase>(
    () => GetExchangeRatesUseCase(getIt<CurrencyRepository>()),
  );

  getIt.registerLazySingleton<GetCurrenciesUseCase>(
    () => GetCurrenciesUseCase(getIt<CurrencyRepository>()),
  );

  getIt.registerLazySingleton<SaveConversionLogUseCase>(
    () => SaveConversionLogUseCase(getIt<CurrencyRepository>()),
  );

  getIt.registerLazySingleton<GetCurrencyHistoryUseCase>(
    () => GetCurrencyHistoryUseCase(getIt<HistoryRepository>()),
  );

  getIt.registerLazySingleton<DeleteCurrencyConversionItemUseCase>(
    () => DeleteCurrencyConversionItemUseCase(getIt<HistoryRepository>()),
  );

  getIt.registerLazySingleton<ClearConversionHistoryUseCase>(
    () => ClearConversionHistoryUseCase(getIt<HistoryRepository>()),
  );

  // Settings feature
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(),
  );

  // getIt.registerFactory<SettingsCubit>(
  //   () => SettingsCubit(
  //     getIt<GetThemeModeUseCase>(),
  //     getIt<SaveThemeModeUseCase>(),
  //   ),
  // );
}
