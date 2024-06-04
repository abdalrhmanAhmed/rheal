import 'dart:async';


import 'package:get/get.dart';

import '../../api_services/auth_api.dart';
import '../../models/otp_model.dart';
import '../../responses/otp_response.dart';
import '../warning_Controller.dart';

// import 'package:shura/view/screens/auth/chang_password_screen.dart';
// import 'package:shura/view/screens/auth/forgot_password_verification_page.dart';

class OtpController extends GetxController implements WarningController {
  var otp = OtpModel().obs;
  Future<void> getOtp({required String phone}) async {
    showAlert("إجراء العمليات", "جاري معالجة طلبك", "opration");
    var response = await AuthApi.getOtp(phone: phone);

    if (response.statusCode == 200) {
      if (response.data['status'] == 201) {
        var otpResponse = OtpResponse.fromJson(response.data);
        otp.value = otpResponse.otps;
        hideLoading();
        showAlert(
            "إجراء العمليات", "سيتم إرسال كود التحقق إلي رقم هاتفك", "success");
        Timer(const Duration(seconds: 2), () {
          hideLoading();
          // Get.to(() => ForgotPasswordVerificationPage(
          //       phone: phone,
          //     ));
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

    if (response.statusCode == 200) {
      if (response.data['status'] == 201) {
        var otpResponse = OtpResponse.fromJson(response.data);
        otp.value = otpResponse.otps;
        hideLoading();
        showAlert("نجاح العملية", "تم التحقق من مطابقة الرقم", "success");
        Timer(const Duration(seconds: 2), () {
          hideLoading();
          // Get.to(() => ChangPasswordScreen());
        });
      } else {
        hideLoading();
        showAlert("خطأ في الإدخال", "رقم الهاتف هذا لا يملك حساب", "danger");
      }
    }
  }
  
  @override
  void hideLoading() {
    // TODO: implement hideLoading
  }
  
  @override
  showAlert(String title, String text, String type) {
    // TODO: implement showAlert
    throw UnimplementedError();
  }
  
  @override
  underDev(type) {
    // TODO: implement underDev
    throw UnimplementedError();
  } //end of login
}
