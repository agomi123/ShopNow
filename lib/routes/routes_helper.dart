import 'package:e_commerce/food/popular_food_details.dart';
import 'package:e_commerce/food/recommended_foot_details.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../cart/cart_page.dart';
import '../home/home_page.dart';
import '../home/main_food_page.dart';
import '../splash/splash_screen.dart';

class RouteHelper {
  static const String initial = "/";
  static const String splashscreen = "/splash-page";
  static const String popularFood = "/popular-food";
  static const String cartPage = "/cart-page";
  static const String recommendedFood = "/recommended-food";
  static String getCartPage() => '$cartPage';
  static String getSplashPage() => '$splashscreen';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getReommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getInitial() => '$initial';
  static List<GetPage> routes = [
    GetPage(name: splashscreen,page: ()=>SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.zoom),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendFoodDetails(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.zoom),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
  ];
}
