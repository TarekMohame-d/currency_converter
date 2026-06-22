import 'package:currency_converter/core/themes/colors.dart';
import 'package:currency_converter/core/widgets/custom_snack_bar.dart';
import 'package:currency_converter/features/history/presentation/cubit/history_cubit.dart';
import 'package:currency_converter/features/history/presentation/cubit/history_state.dart';
import 'package:currency_converter/features/history/presentation/widgets/history_empty_state.dart';
import 'package:currency_converter/features/history/presentation/widgets/history_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Conversion History',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: KColors.primaryColor,
          ),
        ),

        elevation: 0,
        actions: [
          BlocBuilder<HistoryCubit, HistoryState>(
            builder: (context, state) {
              if (state is HistoryLoadSuccess &&
                  state.historyItems.isNotEmpty) {
                return IconButton(
                  icon: const Icon(
                    Icons.delete_sweep_rounded,

                    color: Colors.redAccent,
                  ),
                  tooltip: 'Clear All History',
                  onPressed: () => _showClearAllConfirmation(context),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),

      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HistoryLoadSuccess) {
            if (state.historyItems.isEmpty) {
              return const HistoryEmptyState();
            }

            return HistoryListView(historyItems: state.historyItems);
          }

          if (state is HistoryLoadFailure) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showClearAllConfirmation(BuildContext cubitContext) {
    showDialog(
      context: cubitContext,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Clear All History?'),
        content: const Text(
          'This will permanently delete all records of past conversions. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),

            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              cubitContext.read<HistoryCubit>().clearWholeHistory();

              Navigator.pop(dialogContext);
              customSnackBar(cubitContext, 'History cleared successfully.');
            },
            child: const Text('Clear All', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
