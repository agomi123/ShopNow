import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/food/popular_food_details.dart';
import 'package:e_commerce/home/main_food_page.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../controllers/recommended_product_controller.dart';
import '../routes/routes_helper.dart';
import '../utils/app_constant.dart';
import '../widgets/Big_text.dart';
import '../widgets/Small_text.dart';
import '../widgets/app_column.dart';
import '../widgets/icon_and_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.80);
  var _currpagevalue = 0.0;
  var dotpointer = 0.0;
  double scaleFactor = 0.8;
  var _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currpagevalue = pageController.page!;
        dotpointer = _currpagevalue;
        dotpointer %= 5;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(children: [
            BigText(
              text: "Popular",
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 3),
              child: BigText(text: ".", color: Colors.black26),
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 2),
              child: SmallText(text: "In EcoShop"),
            ),
          ]),
        ),
        SizedBox(height: 10),
        GetBuilder<PropularProductController>(builder: (popularProducts) {
          // print(popularProducts.popularproductlist);
          return popularProducts.isLoaded
              ? Container(
                  height: Dimensions.pageview,
                  child: PageView.builder(
                    itemCount: popularProducts.popularproductlist.length>10?10:popularProducts.popularproductlist.length,
                    controller: pageController,
                    itemBuilder: (context, position) {
                      return _buildpageItem(position,
                          popularProducts.popularproductlist[position]);
                    },
                  ),
                )
              : CircularProgressIndicator(
                  color: Colors.greenAccent,
                );
        }),
    
        //Dots Indicator
        GetBuilder<PropularProductController>(builder: (popularProducts) {
          return DotsIndicator(
              dotsCount: popularProducts.popularproductlist.isEmpty
                  ? 1
                  : (popularProducts.popularproductlist.length > 5
                      ? 5
                      : popularProducts.popularproductlist.length),
              position: dotpointer,
              decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeColor: Colors.amber,
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0))));
        }),
    
        SizedBox(
          height: Dimensions.height30,
        ),
    
        //recommended
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(children: [
            BigText(
              text: "Recommended",
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 3),
              child: BigText(text: ".", color: Colors.black26),
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 2),
              child: SmallText(text: "In EcoShop"),
            ),
          ]),
        ),
        Container(
          height: 900,
          child: GetBuilder<RecommendedProductController>(
            builder: (recommendedProduct) {
              var size = MediaQuery.of(context).size;
    
              /*24 is for notification bar on Android*/
              final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
              final double itemWidth = size.width / 2;
              print(recommendedProduct.recommendedproductlist.length);
              return recommendedProduct.isLoaded
                  ? GridView.builder(
                      itemCount:
                          recommendedProduct.recommendedproductlist.length,
                      //    reverse: true,
                      controller: new ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (itemWidth / itemHeight),
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                        onTap: () {
                            Get.toNamed(
                                RouteHelper.getReommendedFood(index, "home"));
                          },
                          child: Card(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 200,
                                  child: ClipRRect(
                                      child: Image(
                                    image: NetworkImage(
                                        recommendedProduct
                                            .recommendedproductlist[index]
                                            .img!,),
                                            fit: BoxFit.contain,
                                  )),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      recommendedProduct.recommendedproductlist[index].off+"% off ",
                                      style: TextStyle(color: Color.fromARGB(255, 14, 199, 20)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    
                                                    recommendedProduct.recommendedproductlist[index].name!,
                                                    
                                                    softWrap: true,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        overflow: TextOverflow.ellipsis,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )),
                                                  
                                                ]),
                                          ),
                                          
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(Icons.currency_rupee),
                                              SmallText(text: recommendedProduct.recommendedproductlist[index].price!,),
                                              SizedBox(width: 20,),
                                              SmallText(text: "("+recommendedProduct.recommendedproductlist[index].rating+")"),
                                            ],
                                          ),
                                        ]),
                                  ),
                                ),
                                Text('Free Delivery'),
                                // Text('Big Sale!' ,style: TextStyle(color: Colors.red,fontSize: 16),),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : CircularProgressIndicator(
                      color: Colors.greenAccent,
                    );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildpageItem(int index, ProductModel popularproduct) {
    Matrix4 matrix4 = new Matrix4.identity();
    if (index == _currpagevalue.floor()) {
      var currscale = 1 - (_currpagevalue - index) * (1 - scaleFactor);
      var currtrans = _height * (1 - currscale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currpagevalue.floor() + 1) {
      var currscale =
          scaleFactor + (_currpagevalue - index + 1) * (1 - scaleFactor);
      var currtrans = _height * (1 - currscale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currpagevalue.floor() - 1) {
      var currscale = 1 - (_currpagevalue - index) * (1 - scaleFactor);
      var currtrans = _height * (1 - currscale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else {
      var currscale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, _height * (1 - scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, "popular"));
            },
            child: Container(
                height: Dimensions.pageViewContainer,
                margin: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(popularproduct.img!),
                        fit: BoxFit.contain),
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 255, 255, 255))),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 255, 255),
                      // blurRadius: 5.0,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 255, 255),
                      // blurRadius: 5.0,
                      offset: Offset(5, 0),
                    ),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15, left: 10, right: 10),
                child: AppColumn(
                  name: popularproduct.name!,
                  price: popularproduct.price!,
                  off: popularproduct.off!,
                  rating: popularproduct.rating!,
                  reviews: popularproduct.reviews!,
                  stars: popularproduct.stars!,
                  replacable: popularproduct.replacable!,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
