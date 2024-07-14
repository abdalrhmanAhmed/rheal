import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rheal/view/AppColors.dart';

import '../../controllers/console_controller.dart';
import '../../models/consele_model.dart';
import 'console_profile_screen.dart';

class ConsolesScreen extends StatefulWidget {
  ConsolesScreen({Key? key, required this.id, required this.tital})
      : super(key: key);
  final int id;
  final String tital;
  @override
  State<ConsolesScreen> createState() => _ConsolesScreenState();
}

class _ConsolesScreenState extends State<ConsolesScreen> {
  final consoleController = Get.put(ConsoleController());
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    consoleController.getconsole(widget.id);
    super.initState();
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
              iconSize: 35,
            ),
            title: Center(
              child: Text(
                "${widget.tital}",
                style: TextStyle(
                    color: AppColors.text,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
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
          ),
          body: Obx(() {
            return consoleController.isLoding.value == true
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
                            () {},
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
                        itemCount: consoleController
                            .console.length, //_consoleModel!.length,
                        itemBuilder: (context, index) {
                          return buildConsole(consoleController.console[index]);
                        }));
          }),
        ));
  }

  Widget buildConsole(ConsoleModel console) {
    print(console.photo);
    var iconColor = Color.fromARGB(255, 211, 84, 84);
    if (console.isActive == 1) {
      iconColor = AppColors.background;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(
            'https://admin.shurasd.com/upload/catiguriesIcon/${console.photo}',
          ),
        ),
        title: Text(
          "${console.consoleName}",
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          "${console.description}",
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
              Icons.bolt,
              color: iconColor,
            ),
          ],
        ),
        onTap: () {
          Get.to(() => ConsoleProfileScreen(
                consoleName: console.consoleName,
                bio: console.bio,
                skills: console.skills,
                experiance: console.experiance,
                description: console.description,
                photo: console.photo,
                console_id: console.consoleId,
                seviceName: widget.tital,
              ));
        },
      ),
    );
  }
}

Widget popupConsole() {
  return Center();
}
