import 'package:currency_converter/features/history/data/models/history_rate_model.dart';
import 'package:currency_converter/features/history/domain/repository/history_repository.dart';

class GetCurrencyHistoryUseCase {
  final HistoryRepository repository;

  GetCurrencyHistoryUseCase(this.repository);

  Future<List<HistoryRateModel>> call() async {
    return await repository.getRateHistory();
  }
}
