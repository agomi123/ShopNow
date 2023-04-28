import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../base/no_data_page.dart';
import '../controllers/cart_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../home/main_food_page.dart';
import '../routes/routes_helper.dart';
import '../utils/app_constant.dart';
import '../utils/dimensions.dart';
import '../widgets/Big_text.dart';
import '../widgets/Small_text.dart';
import '../widgets/custom_message.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Razorpay _razorpay;
  late String amt;
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void opencheckout() async {
    var options = {
      'key': 'rzp_test_B8hF3CwyGJQwd6',
      'amount': (double.parse(amt) * 100.roundToDouble()).toString(),
      'name': 'Acme Groio',
      'decription': 'Fine T-shirt',
      'prefill': {
        'contact': '888888888',
        'email': 'test@razorpay.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    showCustomSnackBar('Success' + response.paymentId.toString());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    showCustomSnackBar('Failed' + response.message.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    showCustomSnackBar('Success' + response.walletName.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: Dimensions.height20 * 3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundcolor: Colors.greenAccent,
                      size: Dimensions.iconSize24),
                  SizedBox(
                    width: Dimensions.width20 * 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundcolor: Colors.greenAccent,
                        size: Dimensions.iconSize24),
                  ),
                  AppIcon(
                      icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundcolor: Colors.greenAccent,
                      size: Dimensions.iconSize24),
                ],
              ),
            ),
            GetBuilder<CartController>(
              builder: (_cart) {
                return _cart.getItems.length > 0
                    ? Positioned(
                        top: Dimensions.height20 * 4,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: 0,
                        child: Container(
                          margin: EdgeInsets.only(top: Dimensions.height15),
                          child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: GetBuilder<CartController>(
                                builder: (cartcontroller) {
                                  var _cartlist = cartcontroller.getItems;
                                  return ListView.builder(
                                    itemCount: _cartlist.length,
                                    itemBuilder: (_, index) {
                                      return Container(
                                        height: 100,
                                        width: double.maxFinite,
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                var popularindex = Get.find<
                                                        PropularProductController>()
                                                    .popularproductlist
                                                    .indexOf(_cartlist[index]
                                                        .product!);
                                                if (popularindex >= 0) {
                                                  Get.toNamed(RouteHelper
                                                      .getPopularFood(
                                                          popularindex,
                                                          "cartpage"));
                                                } else {
                                                  var recommindex = Get.find<
                                                          RecommendedProductController>()
                                                      .recommendedproductlist
                                                      .indexOf(_cartlist[index]
                                                          .product!);
                                                  if (recommindex < 0) {
                                                    Get.snackbar("Hi there",
                                                        "good to see you");
                                                  } else {
                                                    Get.toNamed(RouteHelper
                                                        .getReommendedFood(
                                                            recommindex,
                                                            "cartpage"));
                                                  }
                                                }
                                              },
                                              child: Container(
                                                width: Dimensions.height20 * 5,
                                                height: Dimensions.height20 * 7,
                                                margin: EdgeInsets.only(
                                                    bottom:
                                                        Dimensions.height20),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.contain,
                                                    image: NetworkImage(
                                                        cartcontroller
                                                            .getItems[index]
                                                            .img!),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius20),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: Dimensions.height20 * 5,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    BigText(
                                                        text: cartcontroller
                                                            .getItems[index]
                                                            .name!,
                                                        color: Colors.black26),
                                                    SmallText(
                                                      text: 'Spicy',
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        BigText(
                                                          text: cartcontroller
                                                              .getItems[index]
                                                              .price
                                                              .toString(),
                                                          color:
                                                              Colors.redAccent,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.only(
                                                              top: Dimensions
                                                                  .height10,
                                                              bottom: Dimensions
                                                                  .height10,
                                                              left: Dimensions
                                                                  .height10,
                                                              right: Dimensions
                                                                  .height10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .radius20),
                                                            color: Colors.white,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  cartcontroller.addItem(
                                                                      _cartlist[
                                                                              index]
                                                                          .product!,
                                                                      -1);
                                                                },
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          173,
                                                                          170,
                                                                          170),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: Dimensions
                                                                        .width10 /
                                                                    2,
                                                              ),
                                                              BigText(
                                                                text: _cartlist[
                                                                        index]
                                                                    .quantity
                                                                    .toString(),
                                                              ),
                                                              SizedBox(
                                                                width: Dimensions
                                                                        .width10 /
                                                                    2,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  cartcontroller.addItem(
                                                                      _cartlist[
                                                                              index]
                                                                          .product!,
                                                                      1);
                                                                },
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          173,
                                                                          170,
                                                                          170),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              )),
                        ),
                      )
                    : NoDataPage(
                        text: "No data",
                      );
              },
            )
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartproduct) {
            return Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  left: Dimensions.height20,
                  right: Dimensions.height20),
              decoration: BoxDecoration(
                  color: Color.fromARGB(66, 177, 175, 175),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                  )),
              child: cartproduct.getItems.length > 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: Dimensions.height20,
                                bottom: Dimensions.height20,
                                left: Dimensions.height20,
                                right: Dimensions.height20),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Dimensions.width10 / 2,
                                ),
                                BigText(
                                    text: "\$ " +
                                        cartproduct.totalAmount.toString()),
                                SizedBox(
                                  width: Dimensions.width10 / 2,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              amt = cartproduct.totalAmount.toString();
                              opencheckout();
                              cartproduct.addToHistory();

                              //  popularproduct.addItem(product);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: Dimensions.height20,
                                  bottom: Dimensions.height20,
                                  left: Dimensions.height20,
                                  right: Dimensions.height20),
                              child: BigText(
                                text: "\$ Check Out",
                                color: Colors.white,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.greenAccent,
                              ),
                            ),
                          ),
                        ])
                  : Container(),
            );
          },
        ));
  }
}
