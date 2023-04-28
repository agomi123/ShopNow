import 'dart:convert';

import 'package:e_commerce/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});
  List<String> cart = [];
  List<String> cartHistory = [];
  void addToCartList(List<CartModel> cartList) {
    // sharedPreferences.remove(AppConstant.CART_HISTORY_KEY);
    // sharedPreferences.remove(AppConstant.CART_KEY);
    cart = [];
    var time = DateTime.now().toString();
    //convert objects to string because sharedprefernces only accpet/store string

    cartList.forEach((element) {
      element.time = time;
      print(element);
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstant.CART_KEY, cart);
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstant.CART_KEY)) {
      carts = sharedPreferences.getStringList(AppConstant.CART_KEY)!;
    }
    List<CartModel> cartlist = [];
    carts.forEach((element) {
      cartlist.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartlist;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstant.CART_HISTORY_KEY)) {
      // cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstant.CART_HISTORY_KEY)!;
    }
    List<CartModel> cartlisthistory = [];
    cartHistory.forEach((element) =>
        cartlisthistory.add(CartModel.fromJson(jsonDecode(element))));
    // print(cartlisthistory.toString() + "m");
    return cartlisthistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstant.CART_HISTORY_KEY)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstant.CART_HISTORY_KEY)!;
    }
    for (int i = 0; i < cart.length; i++) cartHistory.add(cart[i]);
   // removeCart();
    sharedPreferences.setStringList(AppConstant.CART_HISTORY_KEY, cartHistory);
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstant.CART_KEY);
  }
}
