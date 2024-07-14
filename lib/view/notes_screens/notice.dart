import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rheal/controllers/notifaction_controller.dart';
import 'package:rheal/models/notifaction_model.dart';
import 'package:rheal/view/AppColors.dart';

class Notice extends StatefulWidget {
  Notice({Key? key}) : super(key: key);

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  final notifactionController = Get.put(NotifactionController());

  @override
  void initState() {
    notifactionController.getNotifactions();
    super.initState();
  }

  void showWarningDialog(BuildContext context, NotifactionModel warning) {
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(warning.title),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    "https://cemetery2.bmwit.com/public/notification-profile/${warning.image}",
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),
                  Text(warning.description),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('إغلاق'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 29,
          ),
          title: Center(
            child: Text(
              "الاشعارات",
              style: TextStyle(
                color: AppColors.text,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
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
                ],
              ),
            ),
          ),
        ),
        body: Obx(
          () {
            return notifactionController.isLoding.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.text,
                      backgroundColor: AppColors.background,
                    ),
                  )
                : ListView.builder(
                    itemCount: notifactionController.notice.length,
                    itemBuilder: (context, index) {
                      final warning = notifactionController.notice[index];
                      return InkWell(
                        onTap: () {
                          showWarningDialog(context, warning);
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: Card(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 5),
                                    Container(
                                      height:
                                          50, // Increased size for better image display
                                      width:
                                          50, // Increased size for better image display
                                      child: ClipOval(
                                        child: Image.network(
                                          "https://cemetery2.bmwit.com/public/notification-profile/${warning.image}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5),
                                        Text(
                                          warning.title,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: AppColors.background,
                                          ),
                                        ),
                                        Text(
                                          warning.description.length > 30
                                              ? '${warning.description.substring(0, 30)}...'
                                              : warning.description,
                                        ),
                                        Divider(
                                          color: Colors.black12,
                                          thickness: 1,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
