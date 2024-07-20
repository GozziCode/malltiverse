import 'package:flutter/material.dart';
import 'package:malltiverse/screen/cart_screen.dart';
import 'package:malltiverse/screen/checkout_sreen.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constant/constant.dart';
import '../widget/bottom_nav_bar.dart';
import '../widget/custom_appbar.dart';
import 'homescreen.dart';
import 'payment_screen.dart';
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

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    // deleteDatabaseFile();

//Here i listed all the tabs to be shown, included it on the initialize state to make sure it builds on appstart.
//The parameters on the screens are to aid switching the tabs without affecting the bottomnav bar
//and providing a custom app bar
    _screens = [
      const Homescreen(),
      CartScreen(switchTab: switchTab),
      CheckoutSreen(switchToPayment: _switchToPayment),
    ];
  }

//for resetting local database
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
    });
  }

  void _switchToPayment() {
    setState(() {
      _showPaymentScreen = true;
      _showSuccessScreen = false;
    });
  }

  void _switchToCheckout() {
    setState(() {
      _showPaymentScreen = false;
      _showSuccessScreen = false;
    });
  }

  void _switchToSuccess() {
    setState(() {
      _showPaymentScreen = false;
      _showSuccessScreen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<PreferredSizeWidget> appBars = [
      customAppBar(
        context: context,
        title: 'Product List',
        action: Icons.history,
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
              : appBars[_currentIndex],
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: _showSuccessScreen
              ? const SuccessScreen()
              : _showPaymentScreen
                  ? PaymentScreen(switchToSuccess: _switchToSuccess)
                  : _screens[_currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onItemChanged: (index) {
          setState(() {
            _currentIndex = index;
            _showPaymentScreen = false;
            _showSuccessScreen = false;
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
