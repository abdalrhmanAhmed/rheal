import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rheal/view/AppColors.dart';
import 'package:rheal/view/graves/grave.dart';

class RecordDetailScreen extends StatefulWidget {
  final int id;
  final String emirates_id;
  final String name;
  final String gender;
  final String nationality;
  final String cause_of_death;
  final String date_of_death;
  final String hospital;
  final String burial_date;
  final String cemetery_name;
  final String shahed_number;

  RecordDetailScreen({
    Key? key,
    required this.id,
    required this.emirates_id,
    required this.name,
    required this.gender,
    required this.nationality,
    required this.cause_of_death,
    required this.date_of_death,
    required this.hospital,
    required this.burial_date,
    required this.cemetery_name,
    required this.shahed_number,
  }) : super(key: key);

  @override
  State<RecordDetailScreen> createState() => _RecordDetailScreenState();
}

class _RecordDetailScreenState extends State<RecordDetailScreen> {
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
              widget.name,
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
          child: ListView(
            children: [
              // ListTile(
              //   leading: Icon(Icons.insert_drive_file),
              //   title: Text('رقم الهوية'),
              //   subtitle: Text(widget.emirates_id),
              //   onTap: () {},
              // ),
              ListTile(
                leading: Icon(Icons.man),
                title: Text('الإسم'),
                subtitle: Text(widget.name),
                onTap: () {},
              ),
              // ListTile(
              //   leading: Icon(Icons.category),
              //   title: Text('الجنس'),
              //   subtitle: Text(widget.gender),
              //   onTap: () {},
              // ),
              // ListTile(
              //   leading: Icon(Icons.flag),
              //   title: Text('الجنسية'),
              //   subtitle: Text(widget.nationality),
              //   onTap: () {},
              // ),
              // ListTile(
              //   leading: Icon(Icons.curtains_closed_rounded),
              //   title: Text('سبب الوفاة'),
              //   subtitle: Text(widget.cause_of_death),
              //   onTap: () {},
              // ),
              ListTile(
                leading: Icon(Icons.date_range),
                title: Text('تاريخ الوفاة'),
                subtitle: Text(widget.date_of_death),
                onTap: () {},
              ),
              // ListTile(
              // leading: Icon(Icons.local_hospital),
              // title: Text('المستشفي'),
              // subtitle: Text(widget.hospital),
              // onTap: () {},
              // ),
              ListTile(
                leading: Icon(Icons.date_range),
                title: Text('تاريخ الدفن'),
                subtitle: Text(widget.burial_date),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(MdiIcons
                    .graveStone), // Using the cemetery icon from the package
                title: Text('المقبرة'),
                subtitle: Text(widget.cemetery_name),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('رقم الشاهد'),
                subtitle: Text(widget.shahed_number),
                onTap: () {},
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.background,
          onPressed: () {
            Get.to(Grave(id: widget.id));
          },
          child: Icon(
            Icons.pin_drop_outlined,
            color: AppColors.text,
          ),
        ),
      ),
    );
  }
}
