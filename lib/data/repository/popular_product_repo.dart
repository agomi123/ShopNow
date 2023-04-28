import 'package:get/get.dart';
import '../../utils/app_constant.dart';
import '../api/api_client.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});
  Future<Response> getpopularProductList() async {
    return await apiClient.getData("Data/db.json");
  }
}
//"Data/db.json"