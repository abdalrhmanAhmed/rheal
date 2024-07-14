import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html/parser.dart';
import 'package:flutter/services.dart'; // Required for Clipboard functionality
import 'package:rheal/models/libarary_media_model.dart';
import 'package:rheal/view/AppColors.dart';

import '../../../controllers/libarary_media_controller.dart';

class LibararyTextScreen extends StatefulWidget {
  late int id;
  LibararyTextScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  State<LibararyTextScreen> createState() => _LibararyTextScreenState();
}

class _LibararyTextScreenState extends State<LibararyTextScreen> {
  final libararyMediaController = Get.put(LibararyMediaController());
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    libararyMediaController.getLibararyMedia(widget.id, 'text');
    super.initState();
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
                              widget.id, 'text');
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
                            context);
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}

String parseHtmlString(String htmlString) {
  var document = parse(htmlString);
  return parse(document.body?.text ?? "").documentElement?.text ?? "";
}

Widget buildServices(LibararyMediaModel cats, BuildContext context) {
  String plainText = parseHtmlString(cats.media);
  return Column(
    children: [
      SizedBox(height: 10),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    plainText.length > 30
                        ? '${plainText.substring(0, 30)}...'
                        : plainText,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.shadow,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.text_snippet,
                    color: AppColors.background,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FullTextScreen(text: plainText),
            ),
          );
        },
      ),
    ],
  );
}

class FullTextScreen extends StatelessWidget {
  final String text;

  const FullTextScreen({Key? key, required this.text}) : super(key: key);

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
              "النص الكامل",
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
                colors: [AppColors.background, AppColors.background],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: AppColors.shadow),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: text));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم نسخ النص')),
            );
          },
          child: Icon(Icons.copy),
          tooltip: 'نسخ النص',
        ),
      ),
    );
  }
}
