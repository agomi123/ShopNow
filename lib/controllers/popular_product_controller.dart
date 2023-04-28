import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/api/api_client.dart';
import '../data/repository/popular_product_repo.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import 'cart_controller.dart';

class PropularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  // final ApiClient apiClient;
  PropularProductController({required this.popularProductRepo});
  List<dynamic> _popularproductlist = [];
  List<dynamic> get popularproductlist => _popularproductlist;
  late CartController _cart;
  bool _isLoaded = false;
  int _quantity = 0;
  bool get isLoaded => _isLoaded;
  int get quantity => _quantity;
  int _incartItem = 0;
  int get incartItem => _incartItem + _quantity;
  Future<void> getpopularProductList() async {
    Response response = await popularProductRepo.getpopularProductList();
    if (response.statusCode == 200) {
      _popularproductlist = [];
      _popularproductlist.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;

      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity++;
    } else {
      _quantity--;
      if (_quantity + incartItem < 0) {
        if (_incartItem > 0) {
          _quantity = -_incartItem;
        } else
          _quantity = 0;
        Get.snackbar("Item Count", "You can't reduce more!",
            backgroundColor: Colors.greenAccent, colorText: Colors.white);
      }
    }
    update();
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _incartItem = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existIncart(product);
    if (exist) {
      _incartItem = _cart.getQuantity(product);
    }
    //if exist
    //get from storage _incartitems=3;
  }

  void addItem(ProductModel productModel) {
    // if(_quantity>0)
    _cart.addItem(productModel, _quantity);
    _quantity = 0;
    _incartItem = _cart.getQuantity(productModel);
    
    update();
    // }
    // else{
    //    Get.snackbar("Item Count", "Atleast Add an Item !",
    //         backgroundColor: Colors.greenAccent, colorText: Colors.white);
    //   }
  }

  int get totalItems {
    return _cart.totalItem;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
