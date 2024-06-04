import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    ),
    elevation: 0.5,
    iconTheme: IconThemeData(color: Colors.white),
    flexibleSpace: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color(0xFF54D3C2),
            Color(0xFF54D3C2),
          ])),
    ),
    actions: [
      Container(
        margin: EdgeInsets.only(top: 5, right: 55, left: 3, bottom: 10),
      )
    ],
  );
}
