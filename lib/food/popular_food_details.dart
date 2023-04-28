import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/popular_product_controller.dart';
import '../routes/routes_helper.dart';
import '../utils/app_constant.dart';
import '../utils/dimensions.dart';
import '../widgets/Big_text.dart';
import '../widgets/app_column.dart';
import '../widgets/app_icon.dart';
import '../widgets/expanded_textwidget.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PropularProductController>().popularproductlist[pageId];
    Get.find<PropularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            //background image
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 350,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage( product.img!),
                        fit: BoxFit.contain)),
              ),
            ),
            //icon widgets
            Positioned(
                top: Dimensions.height45,
                left: Dimensions.width10,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (page == "cartpage")
                            Get.toNamed(RouteHelper.getCartPage());
                          else
                            Navigator.pop(context);
                        },
                        child: AppIcon(icon: Icons.arrow_back_ios)),
                    GetBuilder<PropularProductController>(
                      builder: (controller) {
                        return GestureDetector(
                          onTap: () {
                            if (controller.totalItems >= 1)
                              Get.toNamed(RouteHelper.getCartPage());
                          },
                          child: Stack(
                            children: [
                              AppIcon(icon: Icons.shopping_cart_outlined, iconColor: Colors.green,),
                              controller.totalItems >= 1
                                  ? Positioned(
                                      right: 0,
                                      top: 0,
                                      child: AppIcon(
                                        icon: Icons.circle,
                                        size: 28,
                                        iconColor: Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    )
                                  : Container(),
                              Get.find<PropularProductController>()
                                          .totalItems >=
                                      1
                                  ? Positioned(
                                      right: 3,
                                      top: 3,
                                      child: BigText(
                                        text: Get.find<
                                                PropularProductController>()
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

                    //
                  ],
                )),
            //intrdouction
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: Dimensions.popularfoodimgsize - 20,
                child: Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      top: Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20),
                      ),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(
                      name: product.name!,
                       price: product.price!,
                       off: product.off!,
                       rating: product.rating!,
                       reviews: product.reviews!,
                       stars: product.stars!,
                       replacable: product.replacable!,
                      
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      BigText(text: "Introduce"),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                              child: ExpandedTextW(
                        text: product.description!,
                      )))
                    ],
                  ),
                )),
          ],
        ),
        bottomNavigationBar: GetBuilder<PropularProductController>(
          builder: (popularproduct) {
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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 15,
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
                          GestureDetector(
                            onTap: () {
                              popularproduct.setQuantity(false);
                            },
                            child: Icon(
                              Icons.remove,
                              color: Color.fromARGB(255, 173, 170, 170),
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width10 / 2,
                          ),
                          BigText(text: popularproduct.incartItem.toString()),
                          SizedBox(
                            width: Dimensions.width10 / 2,
                          ),
                          GestureDetector(
                            onTap: () {
                              popularproduct.setQuantity(true);
                            },
                            child: Icon(
                              Icons.add,
                              color: Color.fromARGB(255, 173, 170, 170),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        popularproduct.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 15,
                            bottom: Dimensions.height20,
                            left: Dimensions.height20,
                            right: Dimensions.height20),
                        child: BigText(
                          text: "Add to Cart",
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
            );
          },
        ));
  }
}
