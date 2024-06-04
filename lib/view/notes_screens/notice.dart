import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animator/animator.dart';

import 'package:get/get.dart';

import '../../controllers/warning_Controller.dart';

class notice extends StatefulWidget {
  notice({Key? key}) : super(key: key);

  @override
  State<notice> createState() => _noticeState();
}

class _noticeState extends State<notice> {
  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      // WarningController().underDev('home');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 29,
            ),
          ),
          title: Center(
            child: Text(
              "الاشعارات",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
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
        ),
        // drawer: Drawer(),
        body: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          child: Animator<double>(
                            duration: Duration(milliseconds: 1500),
                            cycles: 0,
                            curve: Curves.easeInOut,
                            tween: Tween<double>(begin: 0.0, end: 15.0),
                            builder: (context, animatorState, child) =>
                                Container(
                              margin: EdgeInsets.all(animatorState.value),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF54D3C2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF54D3C2).withOpacity(0.5),
                                    offset: Offset(0, 3),
                                    blurRadius: 30,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.notifications_active,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            // Row(
                            //   children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "اشعار جديد",
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xFF54D3C2)),
                            ),
                            //     Text("16:49:59:2022:03:23")
                            //   ],
                            // ),
                            Text("تم تسجيل حسابك بنجاح"),
                            Divider(
                              color: Colors.black12,
                              thickness: 1,
                            )
                          ],
                        ),
                        // SizedBox(
                        //   width: 5,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
