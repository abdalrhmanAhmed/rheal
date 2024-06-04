//declare packages
import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rheal/view/chates/homeScreen.dart';
import 'package:rheal/view/graves/grave.dart';

class Search extends StatefulWidget {
  Search() : super();

  @override
  SearchState createState() => SearchState();
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class SearchState extends State<Search> {
  final _debouncer = Debouncer();

  List<Subject> ulist = [];
  List<Subject> userLists = [];
  //API call for All Subject List

  String url = 'http://cemetery2.bmwit.com/api/graves/get-graves';

  Future<List<Subject>> getAllulistList() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // print(response.body);
        List<Subject> list = parseAgents(response.body);
        return list;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Subject> parseAgents(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Subject>((json) => Subject.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    getAllulistList().then((subjectFromServer) {
      setState(() {
        ulist = subjectFromServer;
        userLists = ulist;
      });
    });
  }

  //Main Widget
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            //Search Bar to List of typed Subject
            Container(
              padding: EdgeInsets.all(15),
              child: TextField(
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  suffixIcon: InkWell(
                    child: Icon(Icons.search),
                  ),
                  contentPadding: EdgeInsets.all(15.0),
                  hintText: 'بحث ',
                ),
                onChanged: (string) {
                  _debouncer.run(() {
                    setState(() {
                      userLists = ulist
                          .where(
                            (u) => (u.name.toLowerCase().contains(
                                  string.toLowerCase(),
                                )),
                          )
                          .toList();
                    });
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.all(5),
                itemCount: userLists.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 5.0),
                            Text('الاسم:  ${userLists[index].name ?? "فارغ"}'),
                            Text(
                                'الجنسية: ${userLists[index].nationality ?? "فارغ"}'),
                            Text(
                                'المقبرة: ${userLists[index].cemetery_name ?? "فارغ"}'),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.to(Grave(
                        name: userLists[index].name ?? "فارغ",
                        cemetery_name: userLists[index].cemetery_name ?? "فارغ",
                        nationality: userLists[index].nationality ?? "فارغ",
                        initialLatitude: userLists[index].northing,
                        initialLongitude: userLists[index].easting,
                      ));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Declare Subject class for json data or parameters of json string/data
//Class For Subject
class Subject {
  var name;
  var nationality;
  double northing; // Changed from Double to double
  double easting; // Changed from Double to double
  var cemetery_name;

  Subject({
    required this.name,
    required this.nationality,
    required this.northing,
    required this.easting,
    required this.cemetery_name,
  });

  factory Subject.fromJson(Map<dynamic, dynamic> json) {
    // Parse northing and easting only if they are numeric strings
    double northing =
        json['northing'] is String && double.tryParse(json['northing']) != null
            ? double.parse(json['northing'])
            : 0.0; // Default value if parsing fails

    double easting =
        json['easting'] is String && double.tryParse(json['easting']) != null
            ? double.parse(json['easting'])
            : 0.0; // Default value if parsing fails

    return Subject(
      name: json['name'],
      nationality: json['nationality'],
      northing: northing,
      easting: easting,
      cemetery_name: json['cemetery_name'],
    );
  }
}
