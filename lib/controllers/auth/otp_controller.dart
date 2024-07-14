import 'dart:async';

import 'package:get/get.dart';
import 'package:rheal/view/auth/chang_password_screen.dart';
import 'package:rheal/view/auth/client/clinet_login_screen.dart';
import 'package:rheal/view/auth/forgot_password_verification_page.dart';
import 'package:rheal/view/main_app_screens/nav.dart';

import '../../api_services/auth_api.dart';
import '../../models/otp_model.dart';
import '../../responses/otp_response.dart';
import '../warning_Controller.dart';

// import 'package:shura/view/screens/auth/chang_password_screen.dart';
// import 'package:shura/view/screens/auth/forgot_password_verification_page.dart';

class OtpController extends GetxController with WarningController {
  var otp = OtpModel().obs;
  Future<void> getOtp({required String phone}) async {
    showAlert("إجراء العمليات", "جاري معالجة طلبك", "opration");
    var response = await AuthApi.getOtp(phone: phone);
    print(response);

    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        // var otpResponse = OtpResponse.fromJson(response.data);
        // otp.value = otpResponse.otps;
        // print(otp.value);
        hideLoading();
        showAlert(
            "إجراء العمليات", "سيتم إرسال كود التحقق إلي رقم هاتفك", "success");
        Timer(const Duration(seconds: 2), () {
          hideLoading();
          Get.to(() => ForgotPasswordVerificationPage(
                phone: phone,
              ));
        });
      } else {
        hideLoading();
        showAlert("خطأ في الإدخال", "رقم الهاتف هذا لا يملك حساب", "danger");
      }
    }
  } //end of getOtp

  Future<void> sendOtp({required String code, required String phone}) async {
    showAlert("إجراء العمليات", "جاري معالجة طلبك", "opration");
    var response = await AuthApi.sendOtp(phone: phone, code: code);
    print(response.data);

    if (response.statusCode == 200) {
      if (response.data['data'] == 'success') {
        // var otpResponse = OtpResponse.fromJson(response.data);
        // otp.value = otpResponse.otps;
        hideLoading();
        showAlert("نجاح العملية", "تم التحقق من مطابقة الرقم", "success");
        Timer(const Duration(seconds: 2), () {
          hideLoading();
          Get.to(() => Nav());
        });
      } else if (response.data['data'] == 'error' &&
          response.data['message'] == 1) {
        hideLoading();
        showAlert("خطأ في الإدخال", "يوجد عدم تطابق الرجاء المحاولة مرة أخرى",
            "danger");
        Timer(const Duration(seconds: 2), () {
          hideLoading();
        });
      } else if (response.data['data'] == 'error' &&
          response.data['message'] == 0) {
        hideLoading();
        showAlert("خطأ في الإدخال",
            "عذرا إنتهت فرص المحاولة الرجاء محاولة التسجيل مجددا", "danger");
        Timer(const Duration(seconds: 2), () {
          hideLoading();
        });
      } else {
        Get.to(() => ClientLoginScreen());
      }
    }
  }

//end of login
}
