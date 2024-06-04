import 'package:get/get.dart';

import '../../api_services/api.dart';
import '../../models/client/client_apointment_model.dart';
import '../../models/consoles/console_orders_model.dart';
import '../../responses/clinet/client_apointment_model.dart';
import '../../responses/console/console_orders_response.dart';


class ConsoleOrdersController extends GetxController {
  var isLoding = true.obs;
  var consoleOrdes = <ConsoleOrdersModel>[].obs;
  var clientApointment = <ClientApointmentModel>[].obs;

  Future<void> getConsoleOrders() async {
    isLoding.value = true;
    var response = await Api.getConsoleOrders();
    var consoleOrdersResponse = ConsoleOrdersResponse.fromJson(response.data);

    consoleOrdes.clear();
    consoleOrdes.addAll(consoleOrdersResponse.consoleOrders);
    isLoding.value = false;
  } //end of getGenres

  Future<void> activeOrder({required int orderId}) async {
    isLoding.value = true;
    var response = await Api.activeOrder(orderId: orderId);
    var consoleOrdersResponse = ConsoleOrdersResponse.fromJson(response.data);

    consoleOrdes.clear();
    consoleOrdes.addAll(consoleOrdersResponse.consoleOrders);
    isLoding.value = false;
  } //end of getGenres

  Future<void> clientOrders() async {
    isLoding.value = true;
    var response = await Api.clientOrders();
    var clinetResponse = ClientApointmentResponse.fromJson(response.data);

    clientApointment.clear();
    clientApointment.addAll(clinetResponse.clientApointmentOrders);
    isLoding.value = false;
  } //end of getGenres

} //end of controller
