import 'dart:async';

import 'package:get/get.dart';

import '../api_services/api.dart';
import '../models/consele_model.dart';
import '../responses/console_response.dart';
import 'main_controller.dart';

class ConsoleController extends GetxController {
  final maincontroller = Get.put(MainController());
  var isLoding = true.obs;
  var console = <ConsoleModel>[].obs;

  Future<void> getconsole(int servicesId) async {
    isLoding.value = true;
    var response = await Api.getConsle(serviceId: servicesId);
    if (response.data["msg"] == "Token is Expired") {
      maincontroller.logout();
    }
    var consoleResponse = ConsoleResponse.fromJson(response.data);
    console.clear();
    console.addAll(consoleResponse.console);
    isLoding.value = false;
  } //end of getGenres
} //end of controller
