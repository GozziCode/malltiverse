import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malltiverse/screen/cart_screen.dart';

import '../constant/constant.dart';
import '../constant/util/card_number_formatter.dart';
import '../widget/custom_credit_card.dart';
import '../widget/expiry_date_formatter.dart';

class PaymentScreen extends StatefulWidget {
  final VoidCallback switchToSuccess;
  const PaymentScreen({super.key, required this.switchToSuccess});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> cardKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cvv = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCreditCard(
              cardNum: cardNumber,
              expiryDate: expiryDate,
              cvv: cvv,
            ),
            SizedBox(height: 50.h),
            Form(
              key: cardKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Card Number',
                      style: GoogleFonts.montserrat(
                          color: AppColors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 47.h,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          cardNumber = value;
                        });
                      },
                      inputFormatters: [CardNumberInputFormatter()],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20),
                          hintText: '0000 0000 0000 0000',
                          hintStyle: GoogleFonts.montserrat(
                              color: AppColors.lightGrey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.lightGrey.withOpacity(.002)),
                              borderRadius: BorderRadius.circular(9))),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 179.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Expiry Date',
                                style: GoogleFonts.montserrat(
                                    color: AppColors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500)),
                            SizedBox(height: 10.h),
                            SizedBox(
                              height: 47.h,
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    expiryDate = value;
                                  });
                                },
                                inputFormatters: [ExpiryDateInputFormatter()],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(20),
                                    hintText: 'MM/YY',
                                    hintStyle: GoogleFonts.montserrat(
                                        color: AppColors.lightGrey,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.lightGrey
                                                .withOpacity(.002)),
                                        borderRadius:
                                            BorderRadius.circular(9))),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 179.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CVV',
                              style: GoogleFonts.montserrat(
                                  color: AppColors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              height: 47.h,
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    cvv = value;
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(20),
                                    hintText: '123',
                                    hintStyle: GoogleFonts.montserrat(
                                        color: AppColors.lightGrey,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.lightGrey
                                                .withOpacity(.002)),
                                        borderRadius:
                                            BorderRadius.circular(9))),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 70.h),
            ActionButton(text: 'Make Payment', onTap: widget.switchToSuccess)
          ],
        ),
      ),
    );
  }
}
