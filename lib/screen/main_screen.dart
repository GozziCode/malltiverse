import 'package:flutter/material.dart';
import 'package:malltiverse/screen/cart/cart_screen.dart';
import 'package:malltiverse/screen/order/order_history.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constant/constant.dart';
import '../widget/custom_appbar.dart';
import 'bottom_nav/bottom_nav_bar.dart';
import 'checkout/checkout_sreen.dart';
import 'home/homescreen.dart';
import 'payment/payment_screen.dart';
import 'success_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _showPaymentScreen = false;
  bool _showSuccessScreen = false;
  bool _showOrderHistory = false;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    // deleteDatabaseFile();
    _screens = [
      const Homescreen(),
      CartScreen(switchTab: switchTab),
      CheckoutSreen(
        switchToPayment: _switchToPayment,
        switchToHome: _goBackToHome,
      ),
      const OrderHistory(),
    ];
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cart.db');
    debugPrint('deleted');
    await deleteDatabase(path);
  }

  void switchTab(int index) {
    setState(() {
      _currentIndex = index;
      _showPaymentScreen = false;
      _showSuccessScreen = false;
      _showOrderHistory = false;
    });
  }

  void _switchToPayment() {
    setState(() {
      _showPaymentScreen = true;
      _showSuccessScreen = false;
      _showOrderHistory = false;
    });
  }

  void _switchToCheckout() {
    setState(() {
      _showPaymentScreen = false;
      _showSuccessScreen = false;
      _showOrderHistory = false;
    });
  }

  void _switchToSuccess() {
    setState(() {
      _showPaymentScreen = false;
      _showSuccessScreen = true;
      _showOrderHistory = false;
    });
  }

  void _showOrderHistoryScreen() {
    setState(() {
      _currentIndex = 3; // This is set to indicate OrderHistory tab
      _showOrderHistory = true;
      _showPaymentScreen = false;
      _showSuccessScreen = false;
    });
  }

  void _goBackToHome() {
    setState(() {
      _currentIndex = 0;
      _showOrderHistory = false;
      _showPaymentScreen = false;
      _showSuccessScreen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<PreferredSizeWidget> appBars = [
      customAppBar(
        context: context,
        title: 'Product List',
        action: Icons.shopping_bag_outlined,
        onTap: _showOrderHistoryScreen,
      ),
      customAppBar(
        context: context,
        title: 'My Cart',
      ),
      customAppBar(
        context: context,
        title: _showPaymentScreen
            ? 'Payment'
            : _showSuccessScreen
                ? 'Success'
                : 'Checkout',
        icon: _showPaymentScreen ? Icons.arrow_back : null,
        onBackPress: _showPaymentScreen ? _switchToCheckout : null,
      ),
      customAppBar(
        context: context,
        title: 'Order History',
        icon: Icons.arrow_back,
        onBackPress: _goBackToHome,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      extendBody: true,
      appBar: _showPaymentScreen
          ? customAppBar(
              context: context,
              title: 'Payment',
              icon: Icons.arrow_back,
              onBackPress: _switchToCheckout,
            )
          : _showSuccessScreen
              ? customAppBar(
                  context: context,
                  title: '',
                )
              : _showOrderHistory
                  ? customAppBar(
                      context: context,
                      title: 'Order History',
                      icon: Icons.arrow_back,
                      onBackPress: _goBackToHome,
                    )
                  : appBars[_currentIndex],
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: _showSuccessScreen
              ? const SuccessScreen()
              : _showPaymentScreen
                  ? PaymentScreen(switchToSuccess: _switchToSuccess)
                  : _showOrderHistory
                      ? const OrderHistory()
                      : _screens[_currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _showOrderHistory ? 0 : _currentIndex,
        onItemChanged: (index) {
          setState(() {
            _currentIndex = index;
            _showPaymentScreen = false;
            _showSuccessScreen = false;
            _showOrderHistory = false;
          });
        },
        navBarItems: [
          NavBarData(
            iconPath: 'assets/svgs/home.svg',
          ),
          NavBarData(
            iconPath: 'assets/svgs/shopping-cart.svg',
          ),
          NavBarData(
            iconPath: 'assets/svgs/group.svg',
          ),
        ],
      ),
    );
  }
}
