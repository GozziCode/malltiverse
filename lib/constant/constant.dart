import 'package:flutter/material.dart';

import 'key/secrets.dart';

class AppColors {
  static const black = Color.fromRGBO(42, 42, 42, 1);
  static const white = Colors.white;
  static const bgColor = Color.fromRGBO(250, 250, 250, 1);
  static const cardBgColor = Color.fromRGBO(237, 237, 237, 0.67);
  static const lightGrey = Colors.grey;
  // fromRGBO(42, 42, 42, 1);
  static const primaryColor = Color(0xFFFF7F7D);
  static const red = Color(0xffd32f2f);
  static const green = Color(0xff388e3c);
}

class Spref {
  static const String isLight = "isLight";
}

class AppUrl {
  static String baseUrl =
      'https://api.timbu.cloud/products?organization_id=$orgId&reverse_sort=false&page=1&size=30&Appid=$myAppId&Apikey=$myApiKey';

  static String imgUrl = "http://api.timbu.cloud/images/";

  static String ratingUrl = 'https://api.timbu.cloud/extrainfo/products';

  // /72a86f2f2b4047a1a162dc666e0e2bb9';
}

extension StringExtension on String {
  String camelCase() {
    final arr = replaceAll('_', ' ').split(' ');
    var str = '';
    arr.removeWhere((e) => e.isEmpty);
    for (var i in arr) {
      str += arr[arr.indexOf(i)][0].toUpperCase() +
          arr[arr.indexOf(i)].substring(1);
      if (i != arr.last) {
        str += ' ';
      }
    }
    return str;
  }
}
