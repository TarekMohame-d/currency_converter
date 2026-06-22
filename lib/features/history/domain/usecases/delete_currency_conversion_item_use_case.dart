import 'package:currency_converter/features/history/domain/repository/history_repository.dart';

class DeleteCurrencyConversionItemUseCase {
  final HistoryRepository repository;

  DeleteCurrencyConversionItemUseCase(this.repository);

  Future<bool> call(int id) async {
    return await repository.deleteHistoryItem(id);
  }
}
