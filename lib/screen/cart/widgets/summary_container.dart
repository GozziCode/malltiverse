import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/constant.dart';
import '../../../provider/cart_provider.dart';
import '../../../widget/action_button.dart';
import 'dash_line.dart';
import 'summary_item.dart';

class SummaryContainer extends StatelessWidget {
  final CartProvider cartProvider;
  final Function(int) switchTab;
  const SummaryContainer({
    super.key,
    required this.cartProvider,
    required this.switchTab,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 17.w,
        right: 17.w,
        top: 10.h,
      ),
      color: AppColors.cardBgColor,
      width: 380.w,
      height: 485.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shopping Summary',
            style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Discount Code',
            style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.lightGrey),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9))),
                    )),
              ),
              SizedBox(
                width: 15.w,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 0,
                    backgroundColor: AppColors.primaryColor),
                child: SizedBox(
                  height: 50.h,
                  width: 43.w,
                  child: Center(
                    child: Text(
                      'Apply',
                      style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          SummaryItem(
            title: 'Sub-Total',
            value: cartProvider.subtotalCost,
          ),
          SizedBox(height: 16.h),
          SummaryItem(
              title: 'Delivery Fee', value: cartProvider.deliveryFeeString),
          SizedBox(height: 16.h),
          SummaryItem(
              title: 'Discount Amount',
              value: cartProvider.discountAmountString),
          SizedBox(height: 30.h),
          const DashLine(color: AppColors.lightGrey),
          SizedBox(height: 16.h),
          SummaryItem(title: 'Total Amount', value: cartProvider.totalAmount),
          SizedBox(height: 18.h),
          ActionButton(
            onTap: () {
              // Use the switchTab method to switch to the checkout tab
              switchTab(2);
            },
            text: 'Checkout',
          ),
         
        ],
      ),
    );
  }
}