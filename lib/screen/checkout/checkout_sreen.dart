import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../provider/cart_provider.dart';
import '../../provider/checkout_provider.dart';
import '../../widget/action_button.dart';
import '../../widget/custom_textfield.dart';

class CheckoutSreen extends StatefulWidget {
  final VoidCallback? switchToPayment;
  final VoidCallback? switchToHome;
  const CheckoutSreen({super.key, this.switchToPayment, this.switchToHome});

  @override
  State<CheckoutSreen> createState() => _CheckoutSreenState();
}

class _CheckoutSreenState extends State<CheckoutSreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final contact1 = TextEditingController();
  final contact2 = TextEditingController();

  String? pickupValue;
  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartProvider>(context);
    final checkoutProvider = Provider.of<CheckoutProvider>(context);

    void validateAndProceed() {
      if (checkoutProvider.pickupValue == null &&
          checkoutProvider.deliveryAddress.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Please select a pickup location or enter a delivery address.'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (contact1.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter the first contact number.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // Validation passed, proceed to payment
        widget.switchToPayment!();
      }
    }

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        child: cartController.cartItems.isEmpty
            ? Center(
                child: Column(
                  children: [
                    SizedBox(height: 300.h),
                    Text('You don\'t have any item in cart yet to checkout',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            color: AppColors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 40.h),
                    SizedBox(
                      width: 200.w,
                      child: ActionButton(
                          text: 'Continue shopping',
                          onTap: () {
                            widget.switchToHome!();
                          }),
                    )
                  ],
                ),
              )
            : Form(
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
                            groupValue: checkoutProvider.pickupValue,
                            onChanged: (val) {
                              setState(() {
                                checkoutProvider.pickupValue = val;
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
                            groupValue: checkoutProvider.pickupValue,
                            onChanged: (val) {
                              setState(() {
                                checkoutProvider.pickupValue = val;
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
                    SizedBox(
                        height: 60.h,
                        child: CustomTextfield(
                          controller: TextEditingController(
                              text: checkoutProvider.deliveryAddress),
                          onChange: (value) {
                            checkoutProvider.deliveryAddress = value;
                          },
                        )),
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
                        child: CustomTextfield(
                          hinText: 'Phone nos 1',
                          controller: contact1,
                          onChange: (value) {
                            checkoutProvider.contact1 = value;
                          },
                        )),
                    SizedBox(height: 15.h),
                    SizedBox(
                        height: 43.h,
                        width: 248.w,
                        child: CustomTextfield(
                          hinText: 'Phone nos 2',
                          controller: contact2,
                          onChange: (value) {
                            checkoutProvider.contact2 = value;
                          },
                        )),
                    SizedBox(height: 62.3.h),
                    Center(
                        child: ActionButton(
                            text: 'Go to Payment',
                            onTap: () {
                              debugPrint(checkoutProvider.getFinalAddress());
                              validateAndProceed();
                            }))
                  ],
                ),
              ),
      ),
    );
  }
}
