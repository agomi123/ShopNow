import 'dart:convert';
import 'package:e_commerce/base/no_data_page.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/routes/routes_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../utils/dimensions.dart';
import '../widgets/Big_text.dart';
import '../widgets/Small_text.dart';
import '../widgets/app_icon.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartItemsPerOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartPerOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> orderTimes = cartItemsPerOrderTimeToList();
    var listCounter = 0;
    Widget timeWidget(int i) {
      var opd = DateTime.now().toString();
      if (i < getCartHistoryList.length) {
        DateTime pt = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var id = DateTime.parse(pt.toString());
        var of = DateFormat("MM/dd/yyyy hh:mm a");
        opd = of.format(id);
      }

      return BigText(text: opd.toString());
    }

    return Scaffold(
      body: Column(children: [
        Container(
          height: 100,
          // color: Colors.greenAccent,
          width: double.maxFinite,
          padding: EdgeInsets.only(top: 45),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BigText(
                text: "Cart History",
                color: Color.fromARGB(255, 1, 1, 1),
              ),
              AppIcon(
                icon: Icons.shopping_cart_outlined,
                iconColor: Colors.greenAccent,
              ),
            ],
          ),
        ),
        GetBuilder<CartController>(builder: (_cartcontroller) {
          print(_cartcontroller.getCartHistoryList().length);
          print("me");
          for (int i = 0; i < _cartcontroller.getCartHistoryList().length; i++)
            print(_cartcontroller.getCartHistoryList()[i].name);
          return _cartcontroller.getCartHistoryList().length > 0
              ? Expanded(
                  child: Container(
                      margin: EdgeInsets.only(
                          top: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(
                          children: [
                            for (int i = 0; i < _cartcontroller.getCartHistoryList().length; i++)
                              Container(
                                height: 120,
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   timeWidget(listCounter),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                              _cartcontroller.getCartHistoryList().length, (index) {
                                            if (listCounter <
                                                getCartHistoryList.length)
                                              listCounter++;
                                            return index <= 2
                                                ? Container(
                                                    height: 80,
                                                    width: 80,
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            Dimensions.width10 /
                                                                2),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                    .radius15 /
                                                                2),
                                                        image: DecorationImage(
                                                          fit: BoxFit.contain,
                                                          image: NetworkImage(
                                                              getCartHistoryList[
                                                                      listCounter -
                                                                          1]
                                                                  .img!),
                                                        )),
                                                  )
                                                : Container();
                                          }),
                                        ),
                                        Container(
                                          height: 80,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SmallText(
                                                text: "Total",
                                              ),
                                              BigText(
                                                text: _cartcontroller.getCartHistoryList()[i].quantity
                                                        .toString() +
                                                    " Items",
                                                color: Colors.black12,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  var orderTime =
                                                      cartPerOrderTimeToList();
                                                  Map<int, CartModel>
                                                      moreOrder = {};
                                                  for (int j = 0;
                                                      j <
                                                          getCartHistoryList
                                                              .length;
                                                      j++) {
                                                    if (getCartHistoryList[j]
                                                            .time ==
                                                        orderTime[i]) {
                                                      moreOrder.putIfAbsent(
                                                          getCartHistoryList[j]
                                                              .id!,
                                                          () => CartModel.fromJson(
                                                              jsonDecode(jsonEncode(
                                                                  getCartHistoryList[
                                                                      j]))));
                                                    }
                                                  }
                                                  Get.find<CartController>()
                                                      .setItems = moreOrder;
                                                  Get.find<CartController>()
                                                      .addToCartList();

                                                  Get.toNamed(RouteHelper
                                                      .getCartPage());
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                    .radius15 /
                                                                2),
                                                    border:
                                                        Border.all(width: 1),
                                                  ),
                                                  child: SmallText(
                                                    text: "one more",
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      )),
                )
              :NoDataPage(text: "Have No data");
        })
      ]),
    );
  }
}
//r
