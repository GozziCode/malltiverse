import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malltiverse/constant/constant.dart';

class CustomTextfield extends StatelessWidget {
  final String hinText;
  const CustomTextfield({super.key, this.hinText = ''});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hinText,
        hintStyle: GoogleFonts.montserrat(
            color: AppColors.lightGrey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightGrey.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(9)),
      ),
    );
  }
}
