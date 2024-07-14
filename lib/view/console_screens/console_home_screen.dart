import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rheal/view/AppColors.dart';

import '../../controllers/console/console_orders_controller.dart';
import '../../controllers/main_controller.dart';
import '../../controllers/warning_Controller.dart';
import '../../models/consoles/console_orders_model.dart';
import '../chates/vidoeCall.dart';
import '../helpers/widgets/primary_button.dart';
import '../helpers/widgets/red_button.dart';
import 'console_screen_helper/app_bar_theem.dart';

class ConsoleHomeScreen extends StatefulWidget {
  @override
  State<ConsoleHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ConsoleHomeScreen> {
  final mainController = Get.find<MainController>();
  final warningcontroller = Get.put(WarningController());
  final consoleOrderController = Get.put(ConsoleOrdersController());
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    consoleOrderController.getConsoleOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBar(),
        body: Obx(() {
          return consoleOrderController.isLoding.value == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.background,
                  ),
                )
              : RefreshIndicator(
                  backgroundColor: AppColors.background,
                  color: AppColors.text.withAlpha(59),
                  onRefresh: () {
                    return Future.delayed(
                      Duration(seconds: 1),
                      () {
                        /// adding elements in list after [1 seconds] delay
                        /// to mimic network call
                        ///
                        /// Remember: setState is necessary so that
                        /// build method will run again otherwise
                        /// list will not show all elements
                        setState(
                          () {
                            consoleOrderController.getConsoleOrders();
                          },
                        );

                        // showing snackbar
                        // _scaffoldKey.currentState!.showSnackBar(
                        //   SnackBar(
                        //     content: const Text('تم تحديث البيانات بنجاح'),
                        //   ),
                        // );
                      },
                    );
                  },
                  child: ListView.builder(
                    // physics: BouncingScrollPhysics(),
                    itemCount: consoleOrderController
                        .consoleOrdes.length, //_consoleModel!.length,
                    itemBuilder: (context, index) {
                      return buildConsole(
                          consoleOrderController.consoleOrdes[index]);
                    },
                  ),
                );
        }),
      ),
    );
  }

  Widget buildConsole(ConsoleOrdersModel consoleOrder) {
    var day = "";
    switch (consoleOrder.day) {
      case '1':
        day = "السبت";
        break;
      case '2':
        day = "الأحد";
        break;
      case '3':
        day = "الإثنين";
        break;
      case '4':
        day = "الثلاثاء";
        break;
      case '5':
        day = "الاربعاء";
        break;
      case '6':
        day = "الخميس";
        break;
      case '7':
        day = "الجمعة";
        break;
      default:
    }
    var iconColor = Color.fromARGB(255, 211, 84, 84);
    if (consoleOrder.status == 1) {
      iconColor = Color.fromARGB(255, 130, 211, 84);
    }
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: consoleOrder.photo != null
              ? NetworkImage(
                  'https://admin.shurasd.com/upload/catiguriesIcon/${consoleOrder.photo}',
                )
              : NetworkImage(
                  'https://shurasd.com/assets/images/shura2.png',
                ),
        ),
        title: Text(
          "${consoleOrder.name}",
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          "طلب إستشارة في ${consoleOrder.service} في يوم ${day} من ${consoleOrder.from}  الي ${consoleOrder.to}",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.radio_button_checked,
              color: iconColor,
            ),
          ],
        ),
        onTap: () {
          consoleOrder.status == 0
              ? Get.dialog(
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
                              child: Text('هل أنت واثق من تأكيد قبول طلب',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(137, 37, 37, 37))),
                            ),
                            Center(
                              child: Text('${consoleOrder.name}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(137, 37, 37, 37))),
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: RedButton(
                                    label: 'لأ',
                                    onPress: () {
                                      Get.back();
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: PrimaryButton(
                                    label: 'نعم',
                                    onPress: () {
                                      warningcontroller.showAlert(
                                          'جاري معالجة طلبك',
                                          'قبول الطلب',
                                          'opration');
                                      consoleOrderController.activeOrder(
                                          orderId: consoleOrder.orderId);
                                      Timer(Duration(seconds: 1), () {
                                        warningcontroller.hideLoading();
                                        Get.back();
                                        consoleOrderController
                                            .getConsoleOrders();
                                      });
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
                )
              : Get.to(
                  () => const VideoCallScreen(),
                );
        },
      ),
    );
  }
}
