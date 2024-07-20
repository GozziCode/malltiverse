import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malltiverse/screen/cart_screen.dart';
import 'package:malltiverse/widget/custom_textfield.dart';

import '../constant/constant.dart';

class CheckoutSreen extends StatefulWidget {
  final VoidCallback switchToPayment;
  const CheckoutSreen({super.key, required this.switchToPayment});

  @override
  State<CheckoutSreen> createState() => _CheckoutSreenState();
}

class _CheckoutSreenState extends State<CheckoutSreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final deliveryAddress = TextEditingController();
  final contact1 = TextEditingController();
  final contact2 = TextEditingController();
  String? pickupValue;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select how to receive your package(s)'),
              SizedBox(height: 10.h),
              Text('Pickup',
                  style: GoogleFonts.montserrat(
                      color: AppColors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 10.h),
              Center(
                child: Row(
                  children: [
                    Radio(
                      visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity),
                      activeColor: AppColors.primaryColor,
                      value: "pickup1",
                      groupValue: pickupValue,
                      onChanged: (val) {
                        setState(() {
                          pickupValue = val;
                        });
                      },
                    ),
                    Text(
                      "Sokoto Street, Area 1, Garki Area 1 AMAC",
                      style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightGrey),
                    )
                  ],
                ),
              ),
              Center(
                child: Row(
                  children: [
                    Radio(
                      visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity),
                      activeColor: AppColors.primaryColor,
                      value: "pickup2",
                      groupValue: pickupValue,
                      onChanged: (val) {
                        setState(() {
                          pickupValue = val;
                        });
                      },
                    ),
                    Text(
                      "Old Secretariat Complex, Area 1, Garki Abaji Abji",
                      style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightGrey),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Text('Delivery',
                  style: GoogleFonts.montserrat(
                      color: AppColors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(height: 60.h, child: const CustomTextfield()),
              SizedBox(height: 25.h),
              Text('Contact',
                  style: GoogleFonts.montserrat(
                      color: AppColors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                  height: 43.h,
                  width: 248.w,
                  child: const CustomTextfield(
                    hinText: 'Phone nos 1',
                  )),
              SizedBox(height: 15.h),
              SizedBox(
                  height: 43.h,
                  width: 248.w,
                  child: const CustomTextfield(
                    hinText: 'Phone nos 2',
                  )),
              SizedBox(height: 62.3.h),
              Center(
                  child: ActionButton(
                      text: 'Go to Payment',
                      onTap: () {
                        widget.switchToPayment();
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
