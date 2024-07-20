import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malltiverse/screen/cart_screen.dart';

import '../constant/constant.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) => Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              width: 380.w,
              height: 138.h,
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.lightGrey.withOpacity(0.3), width: 1.w),
                  borderRadius: BorderRadius.circular(5.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: 'product.photo',
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        height: 78.h,
                        width: 60.w,
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 180.w,
                            child: Text(
                              ' product.name',
                              maxLines: 1,
                              style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          SizedBox(
                            width: 180.w,
                            child: Text(
                              ' product.description',
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black),
                            ),
                          ),
                          SizedBox(height: 15.h),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }
}

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/sneaker.png'),
        const SummaryItem(title: 'Quantity', value: '2 pcs'),
        const SummaryItem(title: 'Price', value: '4500'),
        const SummaryItem(title: 'Date', value: '28 July, 2024'),
        ActionButton(text: 'Buy Again', onTap: () {})
      ],
    );
  }
}
