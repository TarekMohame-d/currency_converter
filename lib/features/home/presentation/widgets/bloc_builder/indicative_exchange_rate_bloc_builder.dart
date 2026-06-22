import 'package:currency_converter/features/home/presentation/cubit/currency_cubit.dart';
import 'package:currency_converter/features/home/presentation/cubit/currency_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndicativeExchangeRateBlocBuilder extends StatelessWidget {
  const IndicativeExchangeRateBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyCubit, CurrencyState>(
      buildWhen: (previous, current) =>
          current is GetSingleCurrencyRateLoading ||
          current is GetSingleCurrencyRateSuccess ||
          current is GetSingleCurrencyRateFailure,
      builder: (context, state) {
        if (state is GetSingleCurrencyRateSuccess) {
          final model = state.currencyPairModel;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Indicative Exchange Rate',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '1 ${model.base} = ${model.rate.toStringAsFixed(4)} ${model.quote}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[500],
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
