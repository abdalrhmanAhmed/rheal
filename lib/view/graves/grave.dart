import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../console_screens/console_screen_helper/app_bar_theem.dart';

class Grave extends StatefulWidget {
  final String? name;
  final String? cemetery_name;
  final String? nationality;
  final double initialLatitude;
  final double initialLongitude;
  Grave({
    Key? key,
    required this.name,
    required this.cemetery_name,
    required this.nationality,
    required this.initialLatitude,
    required this.initialLongitude,
  }) : super(key: key);
  @override
  _GraveState createState() => _GraveState();
}

class _GraveState extends State<Grave> {
  late GoogleMapController mapController;

  double get initialLatitude => widget.initialLatitude;

  double get initialLongitude => widget.initialLongitude;

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
              "بيانات متوفي",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color(0xFF54D3C2),
                  Color(0xFF54D3C2),
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
                    title: 'موقع القير',
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
                        'بيانات المتوفي',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text('الاسم:  ${widget.name ?? "فارغ"}'),
                      Text('المقبرة:   ${widget.cemetery_name ?? "فارغ"}'),
                      Text('الجنسية: ${widget.nationality ?? "فارغ"}'),
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
