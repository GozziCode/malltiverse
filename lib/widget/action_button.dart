import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/constant.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const ActionButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
          backgroundColor: AppColors.primaryColor),
      child: SizedBox(
        height: 55.h,
        width: 306.w,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.montserrat(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black),
          ),
        ),
      ),
    );
  }
}
