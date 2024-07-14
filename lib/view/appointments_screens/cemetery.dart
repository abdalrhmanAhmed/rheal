import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rheal/view/AppColors.dart';

import '../console_screens/console_screen_helper/app_bar_theem.dart';

class Cemetery extends StatefulWidget {
  Cemetery(
      {Key? key,
      required this.name,
      required this.text,
      required this.nationality,
      required this.lat,
      required this.long})
      : super(key: key);
  final String? name;
  final String? text;
  final String? nationality;
  final double lat;
  final double long;
  @override
  _GraveState createState() => _GraveState();
}

class _GraveState extends State<Cemetery> {
  late GoogleMapController mapController;

  double get initialLatitude => widget.lat;

  double get initialLongitude => widget.long;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 29,
            ),
          ),
          title: Center(
            child: Text(
              "بيانات المقبرة",
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
              margin: EdgeInsets.only(top: 5, right: 50, left: 3, bottom: 10),
              child: Stack(
                children: <Widget>[],
              ),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.terrain,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(initialLatitude, initialLongitude),
                zoom: 18.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('currentLocation'),
                  position: LatLng(initialLatitude, initialLongitude),
                  infoWindow: InfoWindow(
                    title: 'موقع المقبرة',
                    snippet: widget.name,
                  ),
                ),
              },
            ),
            Positioned(
              bottom: 100.0,
              left: 20.0,
              right: 20.0,
              child: Card(
                elevation: 5.0,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'بيانات المقبرة',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text('الاسم:  ${widget.lat ?? "فارغ"}'),
                      Text('نبذة:  ${widget.long ?? "فارغ"}'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
