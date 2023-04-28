import 'package:get/get.dart';
import '../data/repository/recommended_product_repo.dart';
import '../models/product_model.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedproductlist = [];
  List<dynamic> get recommendedproductlist => _recommendedproductlist;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> getRecommendedProductList() async {
    print("called");
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedproductlist = [];
      _recommendedproductlist.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }
}
