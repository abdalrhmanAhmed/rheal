import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:rheal/models/libarary_media_model.dart';
import 'package:rheal/view/AppColors.dart';
import '../../../controllers/libarary_media_controller.dart';

class LibararyVoiceScreen extends StatefulWidget {
  final int id;
  LibararyVoiceScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<LibararyVoiceScreen> createState() => _LibararyVoiceScreenState();
}

class _LibararyVoiceScreenState extends State<LibararyVoiceScreen> {
  final libararyMediaController = Get.put(LibararyMediaController());
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    libararyMediaController.getLibararyMedia(widget.id, 'voice');
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Obx(
          () {
            return libararyMediaController.isLoding.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.background,
                    ),
                  )
                : RefreshIndicator(
                    backgroundColor: AppColors.background,
                    color: AppColors.text,
                    onRefresh: () {
                      return Future.delayed(
                        Duration(seconds: 1),
                        () async {
                          await libararyMediaController.getLibararyMedia(
                              widget.id, 'voice');
                          var test = await GetStorage().read('login_first');
                          print("test : $test");
                        },
                      );
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.all(20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: libararyMediaController.libarary_media.length,
                      itemBuilder: (context, index) {
                        return buildServices(
                            libararyMediaController.libarary_media[index],
                            context,
                            audioPlayer);
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}

Widget buildServices(
    LibararyMediaModel cats, BuildContext context, AudioPlayer audioPlayer) {
  return Column(
    children: [
      InkWell(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.background.withOpacity(0.1), AppColors.text],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.audiotrack,
                  color: AppColors.background,
                  size: 50,
                ),
                SizedBox(height: 10),
                Text(
                  "ملف صوتي",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.shadow,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          _showVoiceDialog(
              context,
              "https://cemetery2.bmwit.com/public/libary-details/${cats.media}",
              audioPlayer);
        },
      ),
    ],
  );
}

void _showVoiceDialog(
    BuildContext context, String url, AudioPlayer audioPlayer) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.all(16.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "تشغيل الملف الصوتي",
            style: TextStyle(fontSize: 16, color: AppColors.shadow),
          ),
          SizedBox(height: 20),
          Icon(
            Icons.audiotrack,
            color: AppColors.background,
            size: 50,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            audioPlayer.play(UrlSource(url));
          },
          child: Text('تشغيل'),
        ),
        TextButton(
          onPressed: () {
            audioPlayer.pause();
          },
          child: Text('إيقاف'),
        ),
        TextButton(
          onPressed: () {
            audioPlayer.stop();
            Navigator.of(context).pop();
          },
          child: Text('إلغاء'),
        ),
      ],
    ),
  );
}
