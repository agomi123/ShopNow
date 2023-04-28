import 'package:e_commerce/data/api/api_client.dart';
import 'package:e_commerce/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/signup_body_model.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(SignUpBody signupbody) {
    return apiClient.postData(
        AppConstant.REGISTRATION_URI, signupbody.toJson());
  }

   saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstant.TOKEN,token);
  }
}
