// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:get/get.dart';

import '../api_services/api.dart';
import '../models/order_model.dart';
import '../responses/order_response.dart';
import '../view/order_screens/order_invoice_screen.dart';
import 'warning_Controller.dart';

// import 'package:shura/view/screens/order_screens/order_invoice_screen.dart';

class OrderController extends WarningController {
  var order = OrderModel().obs;

  Future<void> orderCreate(
      {required Map<String, dynamic> orderData,
      required consoleName,
      required serviceName,
      required orderId}) async {
    showAlert("معالجة البيانات", "الرجاء الإنتظار", "opration");
    var response = await Api.orderCreate(orderData: orderData);
    if (response.data["msg"] == "Token is Expired") {}
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        var Orderresponse = OrderResponse.fromJson(response.data);
        order.value = Orderresponse.orders;
        hideLoading();
        showAlert(
            "عملية ناجحة", "تم طلب الإستشارة بنجاح الرجاء الإنتظار", "ok");
        Timer(const Duration(seconds: 1), () {
          hideLoading();
          Get.to(
            () => OrderInvoiceScreen(
                consoleName: consoleName,
                serviceName: serviceName,
                consoleId: orderId),
          );
        });
      }
      if (response.data['status'] != 200) {
        hideLoading();
        showAlert("", "هنالك خطأ في بيانات الطلب", "danger");
      }
    }
  }
}
