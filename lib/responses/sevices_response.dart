
import '../models/services_model.dart';

class ServiceResponse {
  List<ServicesModel> service = [];

  ServiceResponse.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((cat) => service.add(ServicesModel.fromJson(cat)));
  }
}
