import 'package:currency_converter/features/history/data/models/history_rate_model.dart';
import 'package:currency_converter/features/history/presentation/widgets/history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryListView extends StatelessWidget {
  final List<HistoryRateModel> historyItems;

  const HistoryListView({required this.historyItems, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: historyItems.length,
      itemBuilder: (context, index) {
        final item = historyItems[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: HistoryCard(item: item),
        );
      },
    );
  }
}
