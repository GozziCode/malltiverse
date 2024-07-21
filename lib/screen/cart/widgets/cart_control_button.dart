
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/constant.dart';

class AddSubCartButton extends StatelessWidget {
  final String symbol;

  final VoidCallback onTap;
  const AddSubCartButton({
    super.key,
    required this.symbol,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30.w,
        height: 30.h,
        // padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: AppColors.black, width: 1)),
        child: Center(
          child: Text(
            symbol,
            style: GoogleFonts.inter(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black),
          ),
        ),
      ),
    );
  }
}