import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../routes/routes_helper.dart';
import '../utils/app_constant.dart';
import '../utils/dimensions.dart';
import '../widgets/Big_text.dart';
import '../widgets/expanded_textwidget.dart';

class RecommendFoodDetails extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendFoodDetails(
      {Key? key, required this.pageId, required this.page})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedproductlist[pageId];
    Get.find<PropularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.network(product.img!,
              width: double.maxFinite,
              fit: BoxFit.contain,
            )),
            automaticallyImplyLeading: false,
            toolbarHeight: 90,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      if (page == "cartpage")
                        Get.toNamed(RouteHelper.getCartPage());
                      else
                        Navigator.pop(context);
                    },
                    child: AppIcon(icon: Icons.clear)),
                GetBuilder<PropularProductController>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1)
                          Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          Get.find<PropularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.greenAccent,
                                  ),
                                )
                              : Container(),
                          Get.find<PropularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 3,
                                  top: 3,
                                  child: BigText(
                                    text: Get.find<PropularProductController>()
                                        .totalItems
                                        .toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ))
                              : Container(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                // color: Colors.white,
                child: Center(
                    child: BigText(
                  text: product.name!,
                )),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    )),
                padding: EdgeInsets.only(top: 5, bottom: 10),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.height20, right: Dimensions.height20),
                  child: ExpandedTextW(
                    text: product.description!,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PropularProductController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
                  left: Dimensions.width20 * 2.5,
                  right: Dimensions.width20 * 2.5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          controller.setQuantity(false);
                        },
                        child: AppIcon(icon: Icons.remove)),
                    BigText(
                      text: "\$ ${product.price!} X ${controller.incartItem}",
                    ),
                    GestureDetector(
                        onTap: () {
                          controller.setQuantity(true);
                        },
                        child: AppIcon(icon: Icons.add)),
                  ],
                ),
              ),
              Container(
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
                child: Row(
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
                        child: Icon(
                          Icons.favorite,
                          color: Colors.greenAccent,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.addItem(product);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.height20,
                              bottom: Dimensions.height20,
                              left: Dimensions.height20,
                              right: Dimensions.height20),
                          child: BigText(
                            text: "\$ ${product.price!} | Add to Cart",
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.greenAccent,
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
