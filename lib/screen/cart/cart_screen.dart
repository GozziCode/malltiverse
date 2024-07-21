import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';
import 'widgets/cart_card.dart';
import 'widgets/summary_container.dart';

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








