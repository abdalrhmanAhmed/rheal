import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';

import 'api_services/api.dart';
import 'api_services/auth_api.dart';
import 'controllers/main_controller.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart'; // Import flutter_inappwebview

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  AuthApi.initializeInterceptors();
  Api.initializeInterceptors();

  // Initialize the platform implementation for flutter_inappwebview
  InAppWebViewPlatform.instance = InAppWebViewPlatform.instance;

  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.unknown,
      };
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  final mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              backgroundColor: Color.fromARGB(255, 255, 252, 255),
              body: Column(
                children: [
                  const SizedBox(height: 100),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 80),
                      child: Image.asset("images/shura_logo.jpg"),
                    ),
                  ),
                ],
              ))),
      theme: ThemeData(fontFamily: "Ciro"),
    );
  }
}
