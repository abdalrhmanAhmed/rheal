// import 'package:get/get.dart';
// import 'package:shura/api_services/api.dart';
// import 'package:shura/models/auth/client/user_model.dart';

// import 'package:shura/models/services_model.dart';
// import 'package:shura/responses/sevices_response.dart';

// class UserController extends GetxController {
//   var isLoding = true.obs;
//   var userData = <UserModel>[].obs;

//   static Future<void> getClient() async {
//     isLoding.value = true;
//     var serviceResponse;
//     var response = await Api.getUser();
//     if (response.statusCode == 200) {
//       if (response.data['status'] == 200) {
//         serviceResponse = ServiceResponse.fromJson(response.data);
//         userData.va = serviceResponse.
//       }
//       // if (response.data['msg'] == 'Token is Expired' ||
//       //     response.data['status'] == 402) {
//       //   // RefreshTokenController.Refresh();

//       //   getservices(catId);
//       // }
//     }

//     service.clear();
//     service.addAll(serviceResponse.service);
//     isLoding.value = false;
//   } //end of getGenres

//   Future<void> getAllservices() async {
//     isLoding.value = true;
//     var serviceResponse;
//     var response = await Api.getAllServices();
//     if (response.statusCode == 200) {
//       print("father");
//       if (response.data['status'] == 200) {
//         print("one");
//         serviceResponse = ServiceResponse.fromJson(response.data);
//         service.clear();
//         service.addAll(serviceResponse.service);
//       }
//       // if (response.data['msg'] == 'Token is Expired') {
//       //   print("tow");
//       //   RefreshTokenController.Refresh();
//       //   getAllservices();
//       //   service.clear();
//       //   service.addAll(serviceResponse.service);
//       // }
//     }

//     isLoding.value = false;
//   } //end of getGenres

// } //end of controller
