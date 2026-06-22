import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyInputRow extends StatelessWidget {
  final String label;
  final String currencyCode;
  final TextEditingController? controller;
  final bool isReadOnly;
  final Color color;
  final VoidCallback? onCurrencyTap;
  final ValueChanged<String>? onAmountChanged;
  final FormFieldValidator<String>? validator;

  const CurrencyInputRow({
    required this.label,
    required this.currencyCode,
    this.controller,
    this.color = Colors.deepPurple,
    this.isReadOnly = false,
    this.onCurrencyTap,
    this.onAmountChanged,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.blueGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: InkWell(
                onTap: onCurrencyTap,
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 14.r,
                        backgroundColor: color,
                        child: Text(
                          currencyCode.isNotEmpty
                              ? currencyCode.substring(0, 1)
                              : '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        currencyCode,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Theme.of(context).primaryColor,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: 140.w,
              child: TextFormField(
                controller: controller,
                readOnly: isReadOnly,
                onChanged: onAmountChanged,
                validator: validator,
                textAlign: TextAlign.right,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF333333),
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF0F0F0),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  errorMaxLines: 2,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  ),
                  errorStyle: TextStyle(fontSize: 11.sp, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
