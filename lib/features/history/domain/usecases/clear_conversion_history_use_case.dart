import 'package:currency_converter/features/history/domain/repository/history_repository.dart';

class ClearConversionHistoryUseCase {
  final HistoryRepository repository;

  ClearConversionHistoryUseCase(this.repository);

  Future<bool> call() async {
    return await repository.clearHistory();
  }
}
