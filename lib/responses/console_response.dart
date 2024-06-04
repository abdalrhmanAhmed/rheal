
import '../models/consele_model.dart';

class ConsoleResponse {
  List<ConsoleModel> console = [];
  // late int lastPage;

  ConsoleResponse.fromJson(Map<String, dynamic> json) {
    if (json['status'] == 200) {
      json['data']
          .forEach((movie) => console.add(ConsoleModel.fromJson(movie)));
    }
  }
} //end of response
