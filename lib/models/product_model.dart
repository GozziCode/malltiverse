import 'dart:convert';

import 'package:intl/intl.dart';

import '../constant/constant.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final Map<String, dynamic> price;
  final List<String> photos;
  final List<String> categories;
  final bool isAvailable;
  final int quantity;
  double rating;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categories,
    required this.photos,
    required this.isAvailable,
    this.quantity = 1,
    required this.rating,
  });

  // Getter to compute international price
  String get intlPrice {
    if (price.isEmpty) return '';

    final key = price.keys.first;
    final value = price[key];

    if (value is List && value.isNotEmpty && value.first is double) {
      return '${key[0]} ${NumberFormat('#,##0').format((value.first as double) * quantity)}';
    }

    return '₦0';
  }

  // Getter to retrieve the first photo URL (assuming there's at least one photo)
  String get photo {
    if (photos.isEmpty) return '';
    return photos.first;
  }


double get firstPrice {
    if (price.isNotEmpty) {
      var firstValue = price.values.first;
      if (firstValue is List && firstValue.isNotEmpty && firstValue.first is double) {
        return firstValue.first;
      } else if (firstValue is double) {
        return firstValue;
      }
    }
    return 0.0;
  }
  
  // Factory method to create Product from a map
  factory Product.fromMap(Map<String, dynamic> map) {
    final imgUrl = AppUrl.imgUrl;

     var categoriesJson = map['categories'];
  if (categoriesJson is String) {
    categoriesJson = jsonDecode(categoriesJson);
  }
    var categories = <String>[];

    // Ensure categories are correctly parsed
    if (categoriesJson != null && categoriesJson is List) {
      categories = List<String>.from(categoriesJson.map(
      (e) => e is Map<String, dynamic> ? e['name'] as String : 'others',
    ));
    } else {
      categories.add('others');
    }
// Decode photos from JSON string if necessary
  var photosJson = map['photos'];
  if (photosJson is String) {
    photosJson = jsonDecode(photosJson);
  }
   var photos = <String>[];
  if (photosJson != null && photosJson is List) {
    photos = List<String>.from(photosJson.map(
      (e) => '$imgUrl${e['url']}',
    ));
  }

   var price = <String, dynamic>{};
  if (map['current_price'] != null && map['current_price'] is List && (map['current_price'] as List).isNotEmpty) {
    price = (map['current_price'] as List).first;
  }
   
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] ?? '',
      price: price,
      // ((map['current_price'] ?? []) as List).firstOrNull ?? {},
      categories: categories,
      photos: photos,
      isAvailable: map['is_available']?? false,
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
  
Map<String, dynamic> toJson() => toMap();

  // Factory method to create Product from JSON string
  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);


  Map<String, dynamic> toMap() {
  return {
    'id': id,
    'name': name,
    'description': description,
    'price': jsonEncode(price),
    'photos': jsonEncode(photos),
    'categories': jsonEncode(categories),
    'isAvailable': isAvailable ? 1 : 0,
    'quantity': quantity,
    'rating': rating,
  };
}


  // Overrides toString for better debugging
  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, isAvailable:$isAvailable, price: $price, categories: $categories, photos: $photos, rating: $rating)';
  }

  // Override equality operator for comparing products by id
  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  // Override hashCode for consistency with equality operator
  @override
  int get hashCode {
    return id.hashCode;
  }

    
  // Method to update rating
  void updateRating(double newRating) {
    rating = newRating;
  }
}
