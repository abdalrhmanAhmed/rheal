
import '../../models/client/client_apointment_model.dart';

class ClientApointmentResponse {
  List<ClientApointmentModel> clientApointmentOrders = [];

  ClientApointmentResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((order) =>
          clientApointmentOrders.add(ClientApointmentModel.fromJson(order)));
    }
  }
}
