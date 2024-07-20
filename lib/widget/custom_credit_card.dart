import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/constant.dart';

class CustomCreditCard extends StatefulWidget {
  final String cardNum, expiryDate, cvv;
  const CustomCreditCard(
      {super.key,
      // required this.name,
      required this.cardNum,
      required this.expiryDate,
      required this.cvv});

  @override
  State<CustomCreditCard> createState() => _CustomCreditCardState();
}

class _CustomCreditCardState extends State<CustomCreditCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/svgs/card.svg',
          width: 377.w,
          height: 217.h,
        ),
        Positioned(
          bottom: 70.h,
          left: 27.w,
          child: Text(
            widget.cardNum.isEmpty ? 'XXXX XXXX XXXX XXXX' : widget.cardNum,
            style: GoogleFonts.poppins(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.white),
          ),
        ),
        Positioned(
          left: 27.w,
          bottom: 43,
          child: Column(
            children: [
              Text(
                'Card holder name',
                style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white),
              ),
              SizedBox(
                width: 25.w,
              ),
               SizedBox(
                  width: 100.w,
                  child: Text(
                    'Your name',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white),
                  ),
                ),
              
            ],
          ),
        ),
        Positioned(
          left: 27.w,
          bottom: 25,
          child: SizedBox(
            width: 145.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Text(
                'Expiry date',
                style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white),
              ),
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  widget.expiryDate,
                  style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
