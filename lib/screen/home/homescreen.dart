import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malltiverse/constant/constant.dart';
import 'package:provider/provider.dart';

import '../../provider/product_provider.dart';
import '../../widget/action_button.dart';
import 'widgets/category_builder.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshProducts(context),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 232.0.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10.r),
                image: const DecorationImage(
                  image: AssetImage('assets/images/headphone.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Premium Sound, \nPremium Savings',
                      style: GoogleFonts.montserrat(
                          color: AppColors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Limited offer, hope on and get yours now',
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 25.h),
            Consumer<ProductProvider>(
              builder: (context, productsProvider, _) {
                if (productsProvider.isLoading) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height: 15.h),
                        const Text('Loading...'),
                      ],
                    ),
                  );
                } else if (productsProvider.errorMessage != null) {
                  return Center(
                      child: Column(
                    children: [
                      SizedBox(height: 80.h),
                      Text(
                        productsProvider.errorMessage!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            height: 2,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black),
                      ),
                      SizedBox(height: 40.h),
                      SizedBox(
                        width: 200.w,
                        child: ActionButton(
                            text: 'Try again',
                            onTap: productsProvider.fetchProducts),
                      )
                    ],
                  ));
                } else {
                  final categories = productsProvider.categorizedProducts ?? {};
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categories.keys.length,
                    itemBuilder: (_, i) {
                      final key = categories.keys.toList()[i];
                      final value = categories[key] ?? [];
                      return Column(
                        children: [
                          CategoryBuilder(title: key, products: value),
                          if (i < categories.keys.length - 1)
                            const SizedBox(
                              height: 67.0,
                            ),
                        ],
                      );
                    },
                  );
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}
