import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malltiverse/constant/constant.dart';
import 'package:malltiverse/models/cart_model.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class CartScreen extends StatelessWidget {
  final Function(int) switchTab;
  const CartScreen({super.key, required this.switchTab});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cartProvider, _) {
      final cartItems = cartProvider.cartItems;

      return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.w),
          height: 800.h,
          child: Column(children: [
            Expanded(
                child: cartItems.isEmpty
                    ? Center(
                        child: Text(
                          'No items in cart',
                          style: GoogleFonts.montserrat(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          return CartCard(cartItem: cartItems[index]);
                        },
                      )),
            if (cartItems.isNotEmpty)
              SummaryContainer(
                  cartProvider: cartProvider, switchTab: switchTab),
          ]),
        ),
      );
    });
  }
}

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
      height: 450.h,
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
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black),
          ),
        ),
      ),
    );
  }
}

class DashLine extends StatelessWidget {
  final double height;
  final Color color;
  const DashLine({super.key, this.height = 1, this.color = AppColors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(decoration: BoxDecoration(color: color)),
            );
          }),
        );
      },
    );
  }
}

class SummaryItem extends StatelessWidget {
  final String title;
  final String value;
  const SummaryItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black),
        ),
        Text(
          value,
          style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black),
        ),
      ],
    );
  }
}

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
                  cartItem.price.toString(),
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
