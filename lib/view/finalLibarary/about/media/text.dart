import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html/parser.dart';
import 'package:flutter/services.dart'; // Required for Clipboard functionality
import 'package:rheal/models/libarary_media_model.dart';

import '../../../../controllers/libarary_media_controller.dart';

class AboutTextScreen extends StatefulWidget {
  late int id;
  AboutTextScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  State<AboutTextScreen> createState() => _LibararyTextScreenState();
}

class _LibararyTextScreenState extends State<AboutTextScreen> {
  final libararyMediaController = Get.put(LibararyMediaController());
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    libararyMediaController.getAboutMedia(widget.id, 0);
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
                          await libararyMediaController.getLibararyMedia(
                              1, 'text');
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
                colors: [Color(0xFF54D3C2).withOpacity(0.1), Colors.white],
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
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.text_snippet,
                    color: Color(0xFF54D3C2),
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          _showFullTextDialog(context, plainText);
        },
      ),
    ],
  );
}

void _showFullTextDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.all(16.0),
      content: SingleChildScrollView(
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: text));
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم نسخ النص')),
            );
          },
          child: Text('نسخ النص'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('إغلاق'),
        ),
      ],
    ),
  );
}
