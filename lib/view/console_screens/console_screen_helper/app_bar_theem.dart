import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rheal/view/AppColors.dart';

PreferredSizeWidget appBar() {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Icon(Icons.arrow_back_ios),
      iconSize: 35,
    ),
    title: Center(
      child: Text(
        "لوحة التحكم في الحساب",
        style: TextStyle(
            color: AppColors.text, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    ),
    elevation: 0.5,
    iconTheme: IconThemeData(color: AppColors.text),
    flexibleSpace: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            AppColors.background,
            AppColors.background,
          ])),
    ),
    actions: [
      Container(
        margin: EdgeInsets.only(top: 5, right: 55, left: 3, bottom: 10),
      )
    ],
  );
}
