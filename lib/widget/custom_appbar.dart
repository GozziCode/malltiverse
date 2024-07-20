import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/constant.dart';

PreferredSizeWidget customAppBar(
    {required BuildContext context,
    required String title,
    IconData? icon,
    IconData? action,
    VoidCallback? onBackPress}) {
  return AppBar(
    title: Text(
      title,
      style: GoogleFonts.montserrat(
          fontSize: 19.sp, fontWeight: FontWeight.w600, color: AppColors.black),
    ),
    centerTitle: icon != null ? false : true,
    toolbarHeight: 80,
    leadingWidth: icon != null ? 50.w : 150.w,
    leading: icon != null
        ? IconButton(
            icon: Icon(icon, color: Colors.black),
            onPressed: onBackPress ?? () => Navigator.of(context).pop(),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Image.asset(
              'assets/images/malltiverse.png',
            ),
          ),
    elevation: 0,
    backgroundColor: AppColors.bgColor,
    actions: [Icon(action,)],
  );
}
