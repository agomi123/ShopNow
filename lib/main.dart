import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/routes/routes_helper.dart';
import 'package:e_commerce/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth/singup_page.dart';
import 'controllers/popular_product_controller.dart';
import 'controllers/recommended_product_controller.dart';
import 'home/home_page.dart';
import 'home/main_food_page.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   // Get.find<PropularProductController>().getpopularProductList();
   // Get.find<RecommendedProductController>().getRecommendedProductList();
    Get.find<CartController>().getCartData();
    return GetBuilder<PropularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(
          builder: (_) {
            return GetMaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
               initialRoute: RouteHelper.getSplashPage(),
               getPages: RouteHelper.routes,
              home: SplashScreen(),
            );
          },
        );
      },
    );
  }
}
