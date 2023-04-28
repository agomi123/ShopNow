import 'package:e_commerce/auth/auth_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/cart_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/cart_repo.dart';
import '../data/repository/popular_product_repo.dart';
import '../controllers/popular_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';
import '../utils/app_constant.dart';

Future<void> init() async {
  final sharedPrefernces = await SharedPreferences.getInstance();
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstant.BASE_URL));
  Get.lazyPut(() => sharedPrefernces);
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => PropularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));

  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
