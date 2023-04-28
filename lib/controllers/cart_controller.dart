import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems = [];
  void addItem(ProductModel product, int qunatity) {
    int totalQuantity = 0;
    if (qunatity == 0) return;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + qunatity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + qunatity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id!);
      }
      return;
    }
    if (qunatity <= 0) {
      Get.snackbar("Item Count", "You can't reduce more!",
          backgroundColor: Colors.greenAccent, colorText: Colors.white);
      return;
    }
    _items.putIfAbsent(
        product.id!,
        () => CartModel(
              id: product.id,
              name: product.name,
              price: int.parse(product.price!),
              img: product.img,
              quantity: qunatity,
              isExist: true,
              time: DateTime.now().toString(),
              product: product,
            ));
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existIncart(ProductModel product) {
    if (_items.containsKey(product.id!)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) quantity = value.quantity!;
      });
    }
    return quantity;
  }

  int get totalItem {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity!;
    });
    return total;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += (value.price!) * value.quantity!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setitems) {
    _items = {};
    _items = setitems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }
}
