import 'package:flutter/cupertino.dart';

class cart {
  static List<String> Product_name = [];
  static List<String> product_price = [];
  static List<String> product_image = [];
  // static List<String> promo_code = [];
  // static List<String> selleruid = [];
  static List<int> quantity = [];
  static List<String> prquantity = [];
  // static List<String> marketbrands = [];
  // static List<String> brandslisttoupload = [];

  static Future<bool> checkproduct(
    productimg,
  ) {
    for (int i = 0; i < product_image.length; i++) {
      if (productimg == product_image[i]) {
        // break;
        return Future.value(true);
      }
    }
    return Future.value(false);
  }
}
