import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../models/cart_model.dart';
import '../../../provider/cart_provider.dart';
import 'cart_control_button.dart';

class CartCard extends StatelessWidget {
  final CartItem cartItem;
  const CartCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Container(
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
                imageUrl: cartItem.cartImage,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
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
                      cartItem.name,
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
                      cartItem.description,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AddSubCartButton(
                        symbol: '-',
                        onTap: () {
                          cartProvider.decrement(cartItem, context);
                        },
                      ),
                      SizedBox(width: 17.w),
                      Text(
                        '${cartItem.quantity}',
                        style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black),
                      ),
                      SizedBox(width: 15.w),
                      AddSubCartButton(
                        symbol: '+',
                        onTap: () {
                          cartProvider.increment(cartItem, context);
                        },
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      cartProvider.remove(cartItem.id, context);
                    },
                    child: SvgPicture.asset('assets/svgs/delete.svg',
                        height: 18, width: 18)),
                Text(
                  cartItem.price.floor().toString(),
                  style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}