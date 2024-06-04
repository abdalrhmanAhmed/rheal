import 'package:get/get.dart';

import '../controllers/main_controller.dart';
import '../models/refresh_token_model.dart';

class RefreshTokenResponse {
  final mainController = Get.find<MainController>();
  late RefreshTokenModel nToken;
  RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    nToken = RefreshTokenModel.fromJson(json['access_token']);
  }
}
