import 'package:currency_converter/core/themes/colors.dart';
import 'package:currency_converter/features/home/presentation/widgets/bloc_builder/converter_card_bloc_builder.dart';
import 'package:currency_converter/features/home/presentation/widgets/bloc_builder/indicative_exchange_rate_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 40.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Currency Converter',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'Check live rates',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: KColors.darkGrey,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      const ConverterCardBlocBuilder(),
                      SizedBox(height: 30.h),
                      const IndicativeExchangeRateBlocBuilder(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
