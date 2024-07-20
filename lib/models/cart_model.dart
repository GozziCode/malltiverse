import 'dart:convert';

class CartItem {
  final String id;
  final String cartImage;
  final String name;
  final String description;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.cartImage,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? '',
      cartImage: map['cartImage'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity'] ?? 1,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cartImage': cartImage,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
    };
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) => CartItem.fromMap(json.decode(source));

  CartItem decrementQuantity() {
    return CartItem(
      id: id,
      cartImage: cartImage,
      name: name,
      description: description,
      price: price,
      quantity: quantity - 1,
    );
  }

  CartItem incrementQuantity() {
    return CartItem(
      id: id,
      cartImage: cartImage,
      name: name,
      description: description,
      price: price,
      quantity: quantity + 1,
    );
  }
}
