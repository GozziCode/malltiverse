import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constant/constant.dart';
import '../models/product_model.dart';
import '../provider/cart_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartProvider>(context);
    return SizedBox(
      height: 380.h,
      width: 180.w,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 185.h,
          width: 200.w,
          decoration: BoxDecoration(
              color: AppColors.cardBgColor,
              borderRadius: BorderRadius.circular(5.r)),
          child: Center(
            child: product.photo.isEmpty
                ? Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.bgColor,
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/malltiverse.png",
                            ),
                            fit: BoxFit.cover,
                            alignment: Alignment.center)))
                : CachedNetworkImage(
                    fit: BoxFit.contain,
                    height: 112.h,
                    width: 150.w,
                    imageUrl: product.photo,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(product.name,
            softWrap: true,
            maxLines: 1,
            style: GoogleFonts.montserrat(
                fontSize: 12.sp, fontWeight: FontWeight.w600)),
        Text(
          product.description,
          maxLines: 1,
          softWrap: true,
          style: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 5.h),
        SizedBox(
          width: 300.w,
          child: Row(
            children: [
              //TODO: Add rating from db
              for (int i = 0; i <= 3; i++)
                Flexible(
                  flex: 1,
                  child: SvgPicture.asset(
                    'assets/svgs/star.svg',
                    height: 16.92.h,
                    width: 88.w,
                  ),
                ),
              for (int i = 0; i <= 0; i++)
                Flexible(
                  flex: 1,
                  child: SvgPicture.asset(
                    'assets/svgs/unstared.svg',
                    height: 16.92.h,
                    width: 88.w,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 14.h),
        Text(
          product.intlPrice,
          style: GoogleFonts.montserrat(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor),
        ),
        SizedBox(height: 14.h),
        GestureDetector(
          onTap: () {
            cartController.add(product, context);
          },
          child: Container(
            width: cartController.inCart(product) ? 120.w : 93.w,
            height: 38.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: AppColors.primaryColor, width: 1.w)),
            child: Center(
              child: Text(
                'Add${cartController.inCart(product) ? ' more' : ''} to Cart',
                style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
