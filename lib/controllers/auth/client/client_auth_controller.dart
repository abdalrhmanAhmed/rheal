import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../api_services/auth_api.dart';
import '../../../models/auth/client/register_model.dart';
import '../../../models/auth/client/user_model.dart';
import '../../../responses/auth/client/client_register_response.dart';
import '../../../responses/auth/client/user_response.dart';
import '../../../view/main_app_screens/nav.dart';
import '../../warning_Controller.dart';

// import 'package:shura/view/screens/main_app_screens/nav.dart';

class ClientAuthController extends GetxController with WarningController {
  var user = UserModel().obs;
  var reg = RegisterModel().obs;

  Future<void> login({required Map<String, dynamic> loginData}) async {
    showAlert("إجراء العمليات", "جاري معالجة طلبك", "opration");
    var response = await AuthApi.login(loginData: loginData);
    print(response);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        print(response.data);
        var userResponse = UserResponse.fromJson(response.data);
        await GetStorage().write('login_token', userResponse.token);
        await GetStorage().write('login_first', "is_loged");
        // await GetStorage().write('gard', userResponse.user.type);
        user.value = userResponse.user;
        hideLoading();
        showAlert(
            "إجراء العمليات", "تم التعرف علي حسابك اهلا من جديد", "success");
        Timer(
          const Duration(seconds: 2),
          () {
            hideLoading();
            Get.offAll(() => Nav());
          },
        );
      } else {
        // print(GetStorage().read('login_first') == null);
        hideLoading();
        showAlert("خطأ في الإدخال", "يوجد خطأ في رقم الهاتف", "danger");
      }
    }
  } //end of login
}
