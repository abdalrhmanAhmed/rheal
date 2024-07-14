import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart'; // Import flutter_inappwebview
import 'package:rheal/api_services/api.dart';
import 'package:rheal/api_services/auth_api.dart';
import 'package:rheal/controllers/main_controller.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('Handling a background message: ${message.messageId}');
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
  final mainController = Get.put(MainController());

  @override
  // void initState() {
  //   super.initState();

  //   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //   ));

  //   requestPermission();
  //   setupFirebaseMessagingHandlers();

  //   FirebaseMessaging.instance.getToken().then((token) {
  //     print("FCM Token: $token");
  //     // Send the token to your server or use it to send a test notification
  //   });
  // }

  // void requestPermission() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;

  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('User granted permission');
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     print('User granted provisional permission');
  //   } else {
  //     print('User declined or has not accepted permission');
  //   }
  // }

  // void setupFirebaseMessagingHandlers() {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;

  //     if (notification != null && android != null) {
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: Text(notification.title ?? 'Notification'),
  //             content: SingleChildScrollView(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   if (notification.body != null) Text(notification.body!),
  //                 ],
  //               ),
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text('Close'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print('A new onMessageOpenedApp event was published!');
  //     // Handle the message accordingly, e.g., navigate to a specific screen.
  //   });

  //   FirebaseMessaging.instance
  //       .getInitialMessage()
  //       .then((RemoteMessage? message) {
  //     if (message != null) {
  //       print('A new onMessageOpenedApp event was published!');
  //       // Handle the message accordingly, e.g., navigate to a specific screen.
  //     }
  //   });
  // }

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
