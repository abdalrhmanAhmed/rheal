// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rheal/models/libarary_media_model.dart';

import '../../../controllers/libarary_media_controller.dart';

// import 'package:shura/view/screens/order_screens/sub.dart';

class libararyImageScreen extends StatefulWidget {
  late int id;
  libararyImageScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  State<libararyImageScreen> createState() => _Home_PageState();
}

class _Home_PageState extends State<libararyImageScreen> {
  final libarary_media_controller = Get.put(LibararyMediaController());
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    libarary_media_controller.getLibararyMedia(widget.id, 'image');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // start body
        body: Obx(
          () {
            return libarary_media_controller.isLoding.value == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF54D3C2),
                    ),
                  )
                : RefreshIndicator(
                    backgroundColor: Color(0xFF54D3C2),
                    color: Colors.white.withAlpha(59),
                    onRefresh: () {
                      return Future.delayed(
                        Duration(seconds: 1),
                        () async {
                          await libarary_media_controller.getLibararyMedia(
                              1, 'image');
                          var test = await GetStorage().read('login_first');
                          print("test : $test");
                        },
                      );
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.all(20),
                      // physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 2.2,
                        // crossAxisSpacing: 5,
                        // mainAxisSpacing: 5,
                      ),
                      itemCount:
                          libarary_media_controller.libarary_media.length,
                      itemBuilder: (context, index) {
                        return buildServices(
                            libarary_media_controller.libarary_media[index]);
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}

Widget buildServices(LibararyMediaModel cats) {
  return Column(children: [
    Card(
      // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // Set the clip behavior of the card
      clipBehavior: Clip.antiAliasWithSaveLayer,
      // Define the child widgets of the card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 0),
            child: InkWell(
              child: Image.network(
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                "https://cemetery2.bmwit.com/public/libary-details/${cats.media}",
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
          Container(height: 0),
        ],
      ),
    ),
  ]);
}
