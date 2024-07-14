import 'package:rheal/models/notifaction_model.dart';

class NotifactionResponse {
  List<NotifactionModel> category = [];

  NotifactionResponse.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((cat) => category.add(NotifactionModel.fromJson(cat)));
  }
}
