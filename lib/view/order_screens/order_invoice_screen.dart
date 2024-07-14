import 'dart:async';

import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rheal/view/AppColors.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../main_app_screens/nav.dart';

class OrderInvoiceScreen extends StatefulWidget {
  OrderInvoiceScreen(
      {required this.consoleName, this.serviceName, this.consoleId});
  final consoleName;
  final serviceName;
  final consoleId;
  @override
  State<OrderInvoiceScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderInvoiceScreen> {
  var finesh = false;
  @override
  void initState() {
    new Timer(const Duration(seconds: 4), () {
      setState(() {
        finesh = true;
      });
    });
    new Timer(const Duration(seconds: 6), () {
      Get.offAll(() => Nav());
    });
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: finesh == false
          ? Scaffold(
              backgroundColor: Color.fromARGB(255, 211, 192, 84),
              body: Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      Text(
                        'الرجاء الإنتظار ......',
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                        margin: EdgeInsets.fromLTRB(39, 40, 39, 10),
                        child: Animator<double>(
                          duration: Duration(milliseconds: 1500),
                          cycles: 0,
                          curve: Curves.easeInOut,
                          tween: Tween<double>(begin: 0.0, end: 30.0),
                          builder: (context, animatorState, child) => Container(
                            margin: EdgeInsets.all(animatorState.value),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.background,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.background.withOpacity(0.3),
                                  offset: Offset(0, 5),
                                  blurRadius: 30,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              foregroundColor:
                                  Color.fromARGB(255, 110, 110, 110),
                              radius: 100.0,
                              backgroundColor: Colors.yellow,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Scaffold(
              backgroundColor: AppColors.background,
              body: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 180,
                    ),
                    Text(
                      "تم الطلب بنجاح",
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      foregroundColor: Color.fromARGB(255, 110, 110, 110),
                      radius: 120.0,
                      backgroundColor: Colors.yellow,
                      child: Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 180,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "الرجاء الإنتظار ...",
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
