import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rheal/view/AppColors.dart';
import 'package:rheal/view/chates/homeScreen.dart';

import '../helpers/widgets/button_widget.dart';
import '../helpers/widgets/profile_widget.dart';
import '../helpers/widgets/user.dart';
import '../helpers/widgets/user_preferences.dart';

class ConsoleProfileScreen extends StatefulWidget {
  ConsoleProfileScreen(
      {required this.consoleName,
      required this.bio,
      required this.skills,
      this.experiance,
      this.description,
      this.photo,
      this.console_id,
      this.seviceName});
  final consoleName;
  final bio;
  final skills;
  final experiance;
  final description;
  final photo;
  final console_id;
  final seviceName;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ConsoleProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Builder(
      builder: (context) => Directionality(
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
                "ملف المستشار",
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
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 20,
                ),
                ProfileWidget(
                  imagePath:
                      'https://admin.shurasd.com/upload/catiguriesIcon/${widget.photo}',
                  onClicked: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(builder: (context) => EditProfilePage()),
                    // );
                  },
                ),
                const SizedBox(height: 24),
                buildName(),
                const SizedBox(height: 24),
                Center(child: buildUpgradeButton()),
                const SizedBox(height: 20),
                // NumbersWidget(),
                // const SizedBox(height: 48),
                builddescrip(user),
                const SizedBox(height: 10),
                buildskel(user),
                const SizedBox(height: 10),
                buildexper(user),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildName() => Column(
        children: [
          Text(
            widget.consoleName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color.fromARGB(255, 84, 211, 147),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 20, 5),
            child: Text(
              "البايو : ${widget.bio}",
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'حجز موعد للإستشارة',
        onClicked: () {
          Get.to(() => HomeScreen());
        },
      );

  Widget buildskel(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مهارات المستشار',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 84, 211, 147),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.skills != null ? widget.skills : "لا يوجد تفاصسل",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
  Widget buildexper(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'خبرات المستشار',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 84, 211, 147),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.experiance != null ? widget.experiance : "لا يوجد تفاصيل",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
  Widget builddescrip(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'وصف المستشار',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 84, 211, 147),
              ),
            ),
            const SizedBox(height: 9),
            Text(
              widget.description == null ? "لا يوجد وصف" : widget.description,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
