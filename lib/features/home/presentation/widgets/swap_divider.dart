import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwapDivider extends StatelessWidget {
  final VoidCallback? onTap;

  const SwapDivider({this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(color: const Color(0xFFEEEEEE), thickness: 1.5.h),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.swap_vert_rounded,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
