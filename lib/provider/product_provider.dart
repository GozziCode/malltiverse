import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../services/get_product_services.dart';

class ProductProvider extends ChangeNotifier {
  List<Product>? _products;
  Map<String, List<Product>>? _categorizedProducts;
  bool _isLoading = true;
  String? _errorMessage;

  List<Product>? get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, List<Product>>? get categorizedProducts => _categorizedProducts;

  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      GetProductServices productService = GetProductServices();
      _products = await productService.getProducts();
      _categorizeProducts();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _categorizeProducts() {
    if (_products == null || _products!.isEmpty) {
      _categorizedProducts = null;
      return;
    }

    final categoried = <String, List<Product>>{};
    for (final product in _products!) {
      for (final category in product.categories) {
        categoried.putIfAbsent(category, () => []).add(product);
      }
    }
    _categorizedProducts = categoried;
  }
}

final productsListProvider = ChangeNotifierProvider<ProductProvider>(
  create: (context) => ProductProvider(),
);










// // product_provider.dart
// import 'package:flutter/material.dart';
// import '../models/product_model.dart';

// class ProductProvider with ChangeNotifier {

  
//   final List<Product> _techGadgetProducts = [
//     Product(
//       name: 'Joystick gaming pad',
//       description: 'Some description about the product',
//       imgUrl: 'assets/images/18.png',
//       amount: 'N 1450000',
//     ),
//     Product(
//       name: 'iPhone',
//       description: 'Some description about the product',
//       imgUrl: 'assets/images/iphone.png',
//       amount: 'N 1450000',
//     ),
//     Product(
//       name: 'Joystick gaming pad',
//       description: 'Some description about the product',
//       imgUrl: 'assets/images/watch.png',
//       amount: 'N 1450000',
//     ),
//     Product(
//       name: 'iPhone',
//       description: 'Some description about the product',
//       imgUrl: 'assets/images/earpod.png',
//       amount: 'N 1450000',
//     ),
//      Product(
//       name: 'Joystick gaming pad',
//       description: 'Some description about the product',
//       imgUrl: 'assets/images/laptop.png',
//       amount: 'N 1450000',
//     ),
//     Product(
//       name: 'iPhone',
//       description: 'Some description about the product',
//       imgUrl: 'assets/images/powerbank.png',
//       amount: 'N 1450000',
//     ),
//   ];

//   final List<Product> _womensFashionProducts = [
//     Product(
//       name: 'Dress',
//       description: 'Beautiful summer dress',
//       imgUrl: 'assets/images/gown.png',
//       amount: 'N 5000',
//     ),
//     Product(
//       name: 'Handbag',
//       description: 'Elegant leather handbag',
//       imgUrl: 'assets/images/shoe.png',
//       amount: 'N 12000',
//     ),

//     Product(
//       name: 'Dress',
//       description: 'Beautiful summer dress',
//       imgUrl: 'assets/images/gown.png',
//       amount: 'N 5000',
//     ),
//     Product(
//       name: 'Handbag',
//       description: 'Elegant leather handbag',
//       imgUrl: 'assets/images/shoe.png',
//       amount: 'N 12000',
//     ),
//   ];

//   final List<Product> _mensFashionProducts = [
//     Product(
//       name: 'Suit',
//       description: 'Classic men\'s suit',
//       imgUrl: 'assets/images/suite.png',
//       amount: 'N 15000',
//     ),
//     Product(
//       name: 'Watch',
//       description: 'Luxury wristwatch',
//       imgUrl: 'assets/images/watch.png',
//       amount: 'N 25000',
//     ),
//   ];

//   List<Product> get techGadgetProducts => _techGadgetProducts;
//   List<Product> get womensFashionProducts => _womensFashionProducts;
//   List<Product> get mensFashionProducts => _mensFashionProducts;

//   final List<Product> _cart = [];
//   List<Product> get cart => _cart;

  

//   void addToCart(Product product, context) {
//     _cart.add(product);
//     notifyListeners();
//      _showSnackBar('Item added to cart', context);
//   }

//   void removeFromCart(Product product, context) {
//     _cart.remove(product);
//     notifyListeners();
//      _showSnackBar('Item removed from cart', context);
//   }

//   void clearCart() {
//     _cart.clear();
//     notifyListeners();
//   }



//   void _showSnackBar(String message, context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }

// String calculateSubtotal(List<Product> cartItems) {
//     double subtotal = cartItems.fold(
//         0, (sum, item) => sum + double.parse(item.amount.replaceAll('N ', '')));
//     return 'N ${subtotal.toStringAsFixed(2)}';
//   }

//   String calculateTotal(List<Product> cartItems) {
//     double subtotal = cartItems.fold(
//         0, (sum, item) => sum + double.parse(item.amount.replaceAll('N ', '')));
//     double total = subtotal - 3500 + 1500; // subtract discount, add delivery fee
//     return 'N ${total.toStringAsFixed(2)}';
//   }
  

// }
