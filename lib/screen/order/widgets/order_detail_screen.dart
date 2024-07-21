import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:malltiverse/widget/custom_appbar.dart';
import '../../../constant/constant.dart';
import '../../../constant/util/currency_formater.dart';
import '../../../models/order_model.dart';
import '../../../widget/action_button.dart';
import '../../main_screen.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: customAppBar(
          context: context,
          title: 'Order Details',
          onBackPress: () => Navigator.of(context).pop(),
          icon: Icons.arrow_back),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Total Amount: ${CurrencyFormatter.format(order.totalAmount)}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Date: ${order.dateTime.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Address: ${order.address}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(
                order.contactDetails.length > 1
                    ? 'Contact Details: ${order.contactDetails.first}'
                    : 'Contact Details: ${order.contactDetails.join(',')}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Text(
              'Items:',
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: order.items.length,
                itemBuilder: (context, index) {
                  final item = order.items[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5.h),
                    // width: 380.w,
                    height: 100.h,
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.lightGrey.withOpacity(0.3),
                          width: 1.w),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CachedNetworkImage(
                        imageUrl: item.cartImage,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        height: 78.h,
                        width: 60.w,
                      ),
                      title: Text(
                        item.name,
                        style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      subtitle: Text(
                        '${item.quantity} x ${CurrencyFormatter.format(item.price)}',
                        style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                      trailing: Text(
                        'Total: ${CurrencyFormatter.format(item.quantity * item.price)}',
                        style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: ActionButton(
                text: 'Buy Again',
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
