import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../services/db_helper.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];
  double _deliveryFee = 1500;
  double _discountAmount = 3500;

  List<CartItem> get cartItems => _cartItems;

  CartProvider() {
    _loadCart();
  }

  Future<void> _loadCart() async {
    _cartItems = await DBHelper().getCartItems();
    notifyListeners();
  }

  bool inCart(Product product) =>
      _cartItems.any((item) => item.id == product.id);

  Future<void> add(Product product, BuildContext context) async {
    if (inCart(product)) {
      final existingCartItem =
          _cartItems.firstWhere((item) => item.id == product.id);
      await increment(existingCartItem, context);
      return;
    }

    debugPrint('Product price values: ${product.price.values}');
    final cartItem = CartItem(
      id: product.id,
      cartImage: product.photo,
      name: product.name,
      description: product.description,
      price: product.firstPrice,
      quantity: product.quantity,
    );

    _cartItems.add(cartItem);
    await DBHelper().insertCartItem(cartItem);
    notifyListeners();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.name} has been successfully added to cart'),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> increment(CartItem cartItem, BuildContext context) async {
    cartItem.quantity++;
    await DBHelper().updateCartItem(cartItem);
    notifyListeners();
  }

  Future<void> decrement(CartItem cartItem, BuildContext context) async {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
      await DBHelper().updateCartItem(cartItem);
      notifyListeners();
    } else {
      await remove(cartItem.id, context);
    }
  }

  Future<void> remove(String productID, BuildContext context) async {
    _cartItems.removeWhere((item) => item.id == productID);
    await DBHelper().deleteCartItem(productID);
    notifyListeners();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item has been successfully deleted from cart'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> clear() async {
    _cartItems.clear();
    await DBHelper().clearCart();
    notifyListeners();
  }

  // Getters and setters for deliveryFee
  double get deliveryFee => _deliveryFee;
  void setDeliveryFee(double fee) {
    _deliveryFee = fee;
    notifyListeners();
  }

  String get deliveryFeeString =>
      'N ${NumberFormat('#,##0').format(_deliveryFee)}';

  // Getters and setters for discountAmount
  double get discountAmount => _discountAmount;
  void setDiscountAmount(double discount) {
    _discountAmount = discount;
    notifyListeners();
  }

  String get discountAmountString =>
      'N ${NumberFormat('#,##0').format(_discountAmount)}';

  double cartItemAmount(CartItem cartItem) {
    return cartItem.price * cartItem.quantity;
  }

  double get _subtotalCost {
    return _cartItems.map(cartItemAmount).reduce((prev, next) => prev + next);
  }

  String get subtotalCost {
    final str = NumberFormat('#,##0').format(_subtotalCost).toString();
    return 'N $str';
  }

  String get totalAmount {
    final cost = _subtotalCost + _deliveryFee - _discountAmount;
    final str = NumberFormat('#,##0').format(cost).toString();
    return 'N $str';
  }

  Future<void> incrementProduct(Product product, BuildContext context) async {
    final index = _cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      _cartItems[index].quantity += 1;
      await DBHelper().updateCartItem(_cartItems[index]);
      notifyListeners();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Additional ${product.name} has been added to cart'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }
}
