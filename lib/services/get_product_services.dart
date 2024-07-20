import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constant/constant.dart';
import '../models/product_model.dart';

class GetProductServices {
  Future<List<Product>> getProducts() async {
    final url = AppUrl.baseUrl;

    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode >= 400) {
        throw Exception(
            'Failed to fetch products.The issue is from us, will fix it soon.');
      }

      if (res.statusCode == 200) {
        final body = json.decode(res.body);
        final items = (body['items'] as List).cast<Map<String, dynamic>>();
        var productItems = items.map(Product.fromMap).toList();
        // log(productItems.toString());
        return productItems;
      } else {
        throw HttpException('Unexpected status code: ${res.statusCode}');
      }
    } on SocketException catch (_) {
      throw HttpException(
          'No Internet connection. Please check your network settings and try again.');
    } catch (e) {
      debugPrint('Error fetching products: $e');
      rethrow;
    }
  }
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() => message;
}
