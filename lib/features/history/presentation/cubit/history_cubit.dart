import 'package:currency_converter/features/history/domain/usecases/clear_conversion_history_use_case.dart';
import 'package:currency_converter/features/history/domain/usecases/delete_currency_conversion_item_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_currency_history_use_case.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetCurrencyHistoryUseCase getCurrencyHistoryUseCase;
  final DeleteCurrencyConversionItemUseCase deleteCurrencyConversionItemUseCase;
  final ClearConversionHistoryUseCase clearConversionHistoryUseCase;

  HistoryCubit(
    this.getCurrencyHistoryUseCase,
    this.deleteCurrencyConversionItemUseCase,
    this.clearConversionHistoryUseCase,
  ) : super(HistoryInitial());

  Future<void> loadConversionHistory() async {
    emit(HistoryLoading());
    try {
      final items = await getCurrencyHistoryUseCase();

      if (items.isEmpty) {
        emit(HistoryLoadSuccess(const []));
      } else {
        emit(HistoryLoadSuccess(items));
      }
    } catch (e) {
      emit(
        HistoryLoadFailure(
          "Failed to load conversion history: ${e.toString()}",
        ),
      );
    }
  }

  Future<void> deleteItem(int id) async {
    if (state is HistoryLoadSuccess) {
      final currentItems = (state as HistoryLoadSuccess).historyItems;

      try {
        await deleteCurrencyConversionItemUseCase.call(id);

        final updatedItems = currentItems
            .where((item) => item.id != id)
            .toList();
        emit(HistoryLoadSuccess(updatedItems));
      } catch (e) {
        emit(HistoryLoadFailure("Could not delete item."));
      }
    }
  }

  Future<void> clearWholeHistory() async {
    emit(HistoryLoading());
    try {
      final success = await clearConversionHistoryUseCase();
      if (success) {

        emit(HistoryLoadSuccess(const []));
      } else {
        emit(HistoryLoadFailure("Failed to clear the history database logs."));
      }
    } catch (e) {
      emit(HistoryLoadFailure(e.toString()));
    }
  }
}
