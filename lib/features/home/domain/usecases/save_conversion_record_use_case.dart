import 'package:currency_converter/features/home/data/models/conversion_log_model.dart';
import 'package:currency_converter/features/home/domain/repository/currency_repository.dart';

class SaveConversionLogUseCase {
  final CurrencyRepository repository;

  SaveConversionLogUseCase(this.repository);

  Future<void> call(ConversionLogModel log) async {
    await repository.saveConversionLog(log);
  }
}
