import 'dart:async';

// import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../controllers/main_controller.dart';
import '../../controllers/user_data_controller.dart';
import '../../controllers/warning_Controller.dart';
import '../Profile_screens/prof.dart';
import '../appointments_screens/appointments.dart';
import '../graves/search.dart';
import '../helpers/widgets/primary_button.dart';
import '../helpers/widgets/red_button.dart';
import '../messages_screens/messages.dart';
import '../notes_screens/notice.dart';
import '../system_screens/about.dart';
import 'hom_page.dart';

import 'package:get/get.dart';

class MyPlugin extends StatefulWidget {
  @override
  State<MyPlugin> createState() => _MyPluginState();
}

class _MyPluginState extends State<MyPlugin> {
  final mainController = Get.find<MainController>();
  final warningcontroller = Get.put(WarningController());
  final gardcontroller = Get.put(UserDataContoller());

  // final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  Future<void> share() async {
    await FlutterShare.share(
        title: 'تطبيق رحيل',
        text: 'مرحبا بكم في رحيل',
        linkUrl: 'https://cemetery2.bmwit.com',
        chooserTitle: 'تجربة');
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Color(0xFFF2F2F2),
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(about());
                },
                icon: Icon(Icons.help),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  share();
                },
                icon: Icon(Icons.share),
                color: Colors.white,
              ),
              IconButton(
                  color: Colors.white,
                  onPressed: () {
                    Get.dialog(
                      Dialog(
                        backgroundColor: Color(0xFFF2F2F2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          height: 200,
                          width: 300,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Text(
                                      'هل أنت متأكد من عملية تسجيل الخروج',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(137, 37, 37, 37))),
                                ),
                                SizedBox(height: 25),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: RedButton(
                                        label: 'نعم',
                                        onPress: () {
                                          warningcontroller.showAlert(
                                              "جاري معالجة طلبك",
                                              "جاري الخروج من الحساب",
                                              "opration");
                                          Timer(Duration(seconds: 2),
                                              () => mainController.logout());
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: PrimaryButton(
                                        label: 'لأ',
                                        onPress: () {
                                          Get.back();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.logout)),
            ],
            backgroundColor: Color(0xFF54D3C2),
            leading: Container(
              margin: EdgeInsets.only(top: 5, right: 16, left: 3, bottom: 10),
              child: Stack(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Get.to(notice());
                    },
                    icon: Icon(Icons.notifications_active_outlined),
                    iconSize: 30,
                    color: Colors.white,
                  ),
                  Positioned(
                    right: 13,
                    top: 10,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 15,
                        minHeight: 15,
                      ),
                      child: Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
            bottom: TabBar(indicatorColor: Colors.white, tabs: [
              Tab(
                child: Text(
                  "المكتبة",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                icon: Icon(
                  Icons.library_books_sharp,
                  size: 28,
                  color: Colors.white,
                ),
              ),
              Tab(
                child: Text(
                  "المقابر",
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
                icon: Icon(
                  Icons.home,
                  size: 28,
                  color: Colors.white,
                ),
              ),
              Tab(
                child: Text(
                  "الإعلامية",
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
                icon: Icon(
                  Icons.ads_click_sharp,
                  size: 28,
                  color: Colors.white,
                ),
              ),
              Tab(
                child: Text(
                  "قبور",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                icon: Icon(
                  Icons.location_history,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ]),
          ),
          body: TabBarView(children: [
            Home_Page(),
            Appointments(),
            message(),
            Search(),
          ]),
        ));
  }
}
