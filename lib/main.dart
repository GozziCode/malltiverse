import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malltiverse/screen/main_screen.dart';
import 'package:provider/provider.dart';

import 'constant/constant.dart';
import 'provider/cart_provider.dart';
import 'provider/checkout_provider.dart';
import 'provider/product_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
         ChangeNotifierProvider(create: (context) => CheckoutProvider()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(428, 930),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              title: 'Store App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme:
                    ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
                useMaterial3: true,
              ),
              home: const MainScreen(),
            );
          }),
    );
  }
}
