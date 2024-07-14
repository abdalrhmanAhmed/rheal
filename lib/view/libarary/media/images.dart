import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart'; // Import dio package
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rheal/models/libarary_media_model.dart';
import 'package:rheal/view/AppColors.dart';
import 'package:rheal/view/libarary/media/FullScreenImage.dart';

import '../../../controllers/libarary_media_controller.dart';

class libararyImageScreen extends StatefulWidget {
  late int id;
  libararyImageScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  State<libararyImageScreen> createState() => _libararyImageScreenState();
}

class _libararyImageScreenState extends State<libararyImageScreen> {
  final libarary_media_controller = Get.put(LibararyMediaController());

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
        body: Obx(
          () {
            return libarary_media_controller.isLoding.value == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.background,
                    ),
                  )
                : RefreshIndicator(
                    backgroundColor: AppColors.background,
                    color: AppColors.text,
                    onRefresh: () async {
                      await libarary_media_controller.getLibararyMedia(
                          widget.id, 'image');
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.all(20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 2.2,
                      ),
                      itemCount:
                          libarary_media_controller.libarary_media.length,
                      itemBuilder: (context, index) {
                        return buildServices(
                          context,
                          libarary_media_controller.libarary_media[index],
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget buildServices(BuildContext context, LibararyMediaModel cats) {
    return GestureDetector(
      onTap: () {
        Get.to(() => FullScreenImage(
            imageUrl:
                "https://cemetery2.bmwit.com/public/libary-details/${cats.media}"));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 0),
              child: Image.network(
                "https://cemetery2.bmwit.com/public/libary-details/${cats.media}",
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
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
            Container(height: 0),
          ],
        ),
      ),
    );
  }
}
