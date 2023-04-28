import 'package:get/get.dart';

import '../data/repository/auth_repo.dart';
import '../models/response_model.dart';
import '../models/signup_body_model.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isloading = true;
  bool get isloading => _isloading;
  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isloading = true;
    late ResponseModel responseModel;
    Response response = await authRepo.registration(signUpBody);
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.body["token"]);
    }
    _isloading = true;
    update();
    return responseModel; 
  }
}
