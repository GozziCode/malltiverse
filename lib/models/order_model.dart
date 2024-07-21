import 'dart:convert';
import 'cart_model.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime dateTime;
  final String address;
  final List<String> contactDetails;
  final bool paymentConfirmed;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.dateTime,
    required this.address,
    required this.contactDetails,
    required this.paymentConfirmed,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      items: (json.decode(map['items']) as List<dynamic>)
          .map((item) => CartItem.fromMap(item))
          .toList(),
      totalAmount: map['totalAmount']?.toDouble() ?? 0.0,
      dateTime: DateTime.parse(map['dateTime']),
      address: map['address'] ?? '',
      contactDetails: List<String>.from(json.decode(map['contactDetails']) ?? []),
      paymentConfirmed: map['paymentConfirmed'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': json.encode(items.map((item) => item.toMap()).toList()),
      'totalAmount': totalAmount,
      'dateTime': dateTime.toIso8601String(),
      'address': address,
      'contactDetails': json.encode(contactDetails),
      'paymentConfirmed': paymentConfirmed ? 1 : 0,
    };
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
