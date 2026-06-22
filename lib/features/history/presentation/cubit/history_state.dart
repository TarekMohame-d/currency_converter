import 'package:currency_converter/features/history/data/models/history_rate_model.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoadSuccess extends HistoryState {
  final List<HistoryRateModel> historyItems;

  HistoryLoadSuccess(this.historyItems);
}

class HistoryLoadFailure extends HistoryState {
  final String errorMessage;

  HistoryLoadFailure(this.errorMessage);
}
