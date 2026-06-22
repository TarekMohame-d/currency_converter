import 'dart:async';
import 'package:currency_converter/features/home/data/models/currency_model.dart';
import 'package:currency_converter/features/home/presentation/cubit/currency_cubit.dart';
import 'package:currency_converter/features/home/presentation/cubit/currency_state.dart';
import 'package:currency_converter/features/home/presentation/widgets/currency_input_row.dart';
import 'package:currency_converter/features/home/presentation/widgets/swap_divider.dart';
import 'package:currency_converter/features/home/presentation/widgets/currency_picker_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConverterCardBlocBuilder extends StatefulWidget {
  const ConverterCardBlocBuilder({super.key});

  @override
  State<ConverterCardBlocBuilder> createState() =>
      _ConverterCardBlocBuilderState();
}

class _ConverterCardBlocBuilderState extends State<ConverterCardBlocBuilder> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController(
    text: "10.00",
  );
  final TextEditingController _convertedController = TextEditingController();
  double _currentRate = 1.0;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _amountController.dispose();
    _convertedController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _calculateConversion(String value, double rate) {
    final double input = double.tryParse(value) ?? 0.0;
    if (input <= 0) {
      _convertedController.text = "0.00";
      return;
    }
    _convertedController.text = (input * rate).toStringAsFixed(2);
  }

  void _debounceSaveToHistory({
    required String value,
    required String base,
    required String quote,
    required double rate,
  }) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 600), () {
      final double input = double.tryParse(value) ?? 0.0;
      if (input > 0 && (_formKey.currentState?.validate() ?? false)) {
        context.read<CurrencyCubit>().logConversionToDatabase(
          base: base,
          quote: quote,
          rate: rate,
          amount: input,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrencyCubit, CurrencyState>(
      listenWhen: (previous, current) =>
          current is GetSingleCurrencyRateSuccess,
      listener: (context, state) {
        if (state is GetSingleCurrencyRateSuccess) {
          final model = state.currencyPairModel;
          _currentRate = model.rate;

          // Safely set visual controllers outside the UI build sequence pass
          _calculateConversion(_amountController.text, _currentRate);

          // Automatically save to local history when rates update
          final double initialAmount =
              double.tryParse(_amountController.text) ?? 0.0;
          if (initialAmount > 0) {
            context.read<CurrencyCubit>().logConversionToDatabase(
              base: model.base,
              quote: model.quote,
              rate: _currentRate,
              amount: initialAmount,
            );
          }
        }
      },
      buildWhen: (previous, current) =>
          current is GetSingleCurrencyRateLoading ||
          current is GetSingleCurrencyRateSuccess ||
          current is GetSingleCurrencyRateFailure,
      builder: (context, state) {
        if (state is GetSingleCurrencyRateSuccess) {
          final model = state.currencyPairModel;
          _currentRate = model.rate;

          return _container(
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  CurrencyInputRow(
                    label: 'Amount',
                    currencyCode: model.base,
                    controller: _amountController,
                    color: Colors.blueAccent,
                    onAmountChanged: (val) {
                      setState(() => _calculateConversion(val, _currentRate));
                      _debounceSaveToHistory(
                        value: val,
                        base: model.base,
                        quote: model.quote,
                        rate: _currentRate,
                      );
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Required';
                      }
                      final parsedValue = double.tryParse(value);
                      if (parsedValue == null) {
                        return 'Numbers only';
                      }
                      if (parsedValue <= 0) {
                        return 'Must be > 0';
                      }
                      return null;
                    },
                    onCurrencyTap: () => _showCurrencyPicker(
                      mainContext: context,
                      currentBase: model.base,
                      currentQuote: model.quote,
                      isBaseSelection: true,
                    ),
                  ),

                  SizedBox(height: 15.h),

                  SwapDivider(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<CurrencyCubit>().swapCurrencies();
                      }
                    },
                  ),

                  SizedBox(height: 15.h),

                  CurrencyInputRow(
                    label: 'Converted Amount',
                    currencyCode: model.quote,
                    controller: _convertedController,
                    isReadOnly: true,
                    color: Colors.red,
                    onCurrencyTap: () => _showCurrencyPicker(
                      mainContext: context,
                      currentBase: model.base,
                      currentQuote: model.quote,
                      isBaseSelection: false,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is GetSingleCurrencyRateFailure) {
          return _container(const Center(child: Text('Something went wrong')));
        }

        return _container(
          Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ),
        );
      },
    );
  }

  Widget _container(Widget child) {
    return Container(
      padding: EdgeInsets.all(20.w),
      width: double.infinity,
      height: 300.h,
      decoration: BoxDecoration(
        color: Color(0xfffbfbf2),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15.r,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }

  Future<void> _showCurrencyPicker({
    required BuildContext mainContext,
    required String currentBase,
    required String currentQuote,
    required bool isBaseSelection,
  }) async {
    final cubit = mainContext.read<CurrencyCubit>();
    cubit.getCurrencies();

    final CurrencyModel? selected = await showModalBottomSheet<CurrencyModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xfffbfbf2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (modalContext) => BlocProvider.value(
        value: cubit,
        child: const CurrencyPickerBottomSheet(),
      ),
    );

    if (selected != null) {
      final String newBase = isBaseSelection ? selected.isoCode : currentBase;
      final String newQuote = isBaseSelection ? currentQuote : selected.isoCode;
      cubit.getExchangeRates(newBase, newQuote);
    }
  }
}
