// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:shura/view/screens/auth/we.dart';
// import 'package:shura/view/screens/main_app_screens/nav.dart';

mixin class WarningController {
  showAlert(String title, String text, String type) {
    Get.defaultDialog(
      title: title,
      middleText: text,
      backgroundColor: type == "opration"
          ? Colors.blue.withOpacity(.9)
          : type == "danger"
              ? Colors.red.withOpacity(.9)
              : Colors.green.withOpacity(.9),
      titleStyle: const TextStyle(color: Colors.white),
      middleTextStyle: const TextStyle(color: Colors.white),
      radius: 30,
      content: Center(
        child: Column(
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 18,
            ),
            type == "opration"
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : type == "danger"
                    ? const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      )
                    : const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30,
                      ),
          ],
        ),
      ),
    );
  }

  underDev(type) {
    Get.defaultDialog(
      title: "لا يزال تحت التطوير",
      middleText: "هذا الجزء من التطبيق لا يزال تحت التطوير",
      backgroundColor: Colors.red.withOpacity(.9),
      titleStyle: const TextStyle(color: Colors.white),
      middleTextStyle: const TextStyle(color: Colors.white),
      radius: 30,
      content: Center(
        child: Column(
          children: const [
            Text(
              'نقوم في هذه اللحظات بإتمام اعمال عظيمة تستحق إهتمامكم هذا قليل و القادم اعظم',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 18,
            ),
            Icon(
              Icons.close,
              color: Colors.white,
              size: 30,
            )
          ],
        ),
      ),
    );

    Timer(const Duration(seconds: 2), () {
      if (Get.isDialogOpen!) {
        // type == 'home' ? Get.to(() => nav()) : Get.to(() => we());
      }
    });
  }

  void hideLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  } //end of closeLoading
}
