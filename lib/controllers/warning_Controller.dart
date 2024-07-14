// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rheal/view/AppColors.dart';
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
      titleStyle: const TextStyle(color: AppColors.text),
      middleTextStyle: const TextStyle(color: AppColors.text),
      radius: 30,
      content: Center(
        child: Column(
          children: [
            Text(
              text,
              style: const TextStyle(color: AppColors.text),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 18,
            ),
            type == "opration"
                ? const CircularProgressIndicator(
                    color: AppColors.text,
                  )
                : type == "danger"
                    ? const Icon(
                        Icons.close,
                        color: AppColors.text,
                        size: 30,
                      )
                    : const Icon(
                        Icons.check,
                        color: AppColors.text,
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
      titleStyle: const TextStyle(color: AppColors.text),
      middleTextStyle: const TextStyle(color: AppColors.text),
      radius: 30,
      content: Center(
        child: Column(
          children: const [
            Text(
              'نقوم في هذه اللحظات بإتمام اعمال عظيمة تستحق إهتمامكم هذا قليل و القادم اعظم',
              style: TextStyle(color: AppColors.text),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 18,
            ),
            Icon(
              Icons.close,
              color: AppColors.text,
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
