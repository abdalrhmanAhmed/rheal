import 'dart:async';

import 'package:get/get.dart';

import '../api_services/api.dart';
import '../models/user_data_model.dart';
import '../responses/user_data_response.dart';
import 'warning_Controller.dart';


class UserDataContoller extends GetxController with WarningController {
  var userData = UserDataModel().obs;
  var isLoding = false.obs;

  Future<void> getUserData() async {
    var response = await Api.getUser();
    isLoding.value = false;
    if (response.statusCode == 200) {
      if (response.data['code'] == 200) {
        var userResponse = UserDataResponse.fromJson(response.data);
        userData.value = userResponse.user;
        isLoding.value = true;
      } else {
        showAlert("خطأ في الإتصال",
            "انت تواجة مشكلة في الإتصال او بياناتك غير موجودة", "danger");
      }
    }
  }
  

}
