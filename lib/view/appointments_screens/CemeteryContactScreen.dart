import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rheal/controllers/cemetery_contact_controller.dart';
import 'package:rheal/models/notifaction_model.dart';
import 'package:rheal/view/AppColors.dart';

class CemeteryContactScreen extends StatefulWidget {
  late int id;
  CemeteryContactScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<CemeteryContactScreen> createState() => _NoticeState();
}

class _NoticeState extends State<CemeteryContactScreen> {
  final cemeteryContactController = Get.put(CemeteryContactController());

  @override
  void initState() {
    cemeteryContactController.getNotifactions(widget.id);
    super.initState();
  }

  void showContactDialog(BuildContext context, CemeteryContactModel contact) {
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(contact.type),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contact.value),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: contact.value));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('تم نسخ النص')),
                      );
                    },
                    child: Text('نسخ'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('إغلاق'),
                  ),
                ],
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
              "بيانات التواصل",
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
            return cemeteryContactController.isLoding.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.background,
                    ),
                  )
                : ListView.builder(
                    itemCount: cemeteryContactController.contact.length,
                    itemBuilder: (context, index) {
                      final contact = cemeteryContactController.contact[index];
                      return InkWell(
                        onTap: () {
                          showContactDialog(context, contact);
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: Card(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5),
                                        Text(
                                          contact.type,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: AppColors.background,
                                          ),
                                        ),
                                        Text(
                                          contact.value.length > 30
                                              ? '${contact.value.substring(0, 30)}...'
                                              : contact.value,
                                        ),
                                        Divider(
                                          color: AppColors.shadow,
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
