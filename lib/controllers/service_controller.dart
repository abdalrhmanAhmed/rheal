// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';

import '../api_services/api.dart';
import '../models/services_model.dart';
import '../responses/sevices_response.dart';

class ServiceController extends GetxController {
  var isLoding = true.obs;
  var service = <ServicesModel>[].obs;

  Future<void> getservices(int catId) async {
    isLoding.value = true;
    var serviceResponse;
    var response = await Api.getServices(catId: catId);
    if (response.statusCode == 200) {
      if (response.data['code'] == 200) {
        serviceResponse = ServiceResponse.fromJson(response.data);
      }
      // if (response.data['msg'] == 'Token is Expired' ||
      //     response.data['status'] == 402) {
      //   // RefreshTokenController.Refresh();

      //   getservices(catId);
      // }
    }

    service.clear();
    service.addAll(serviceResponse.service);
    isLoding.value = false;
  } //end of getGenres

  Future<void> getAllservices() async {
    isLoding.value = true;
    var serviceResponse;
    var response = await Api.getAllServices();
    if (response.statusCode == 200) {
      // print("father");
      if (response.data['status'] == 200) {
        // print("one");
        serviceResponse = ServiceResponse.fromJson(response.data);
        service.clear();
        service.addAll(serviceResponse.service);
      }
      // if (response.data['msg'] == 'Token is Expired') {
      //   print("tow");
      //   RefreshTokenController.Refresh();
      //   getAllservices();
      //   service.clear();
      //   service.addAll(serviceResponse.service);
      // }
    }

    isLoding.value = false;
  } //end of getGenres

} //end of controller
