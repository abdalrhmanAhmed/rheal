// lib/models/record.dart

class RecordModel {
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

  RecordModel(
      {required this.id,
      required this.emirates_id,
      required this.name,
      required this.gender,
      required this.nationality,
      required this.cause_of_death,
      required this.date_of_death,
      required this.hospital,
      required this.burial_date,
      required this.shahed_number,
      required this.cemetery_name});

  factory RecordModel.fromJson(Map<String, dynamic> json) {
    return RecordModel(
      id: json['id'],
      emirates_id: json['emirates_id'] == '' ? 'غير مدرج' : json['emirates_id'],
      name: json['name'] == '' ? 'غير مدرج' : json['name'],
      gender: json['gender'] == '' ? 'غير مدرج' : json['gender'],
      nationality: json['nationality'] == '' ? 'غير مدرج' : json['nationality'],
      cause_of_death:
          json['cause_of_death'] == '' ? 'غير مدرج' : json['cause_of_death'],
      date_of_death:
          json['date_of_death'] == '' ? 'غير مدرج' : json['date_of_death'],
      hospital: json['hospital'] == '' ? 'غير مدرج' : json['hospital'],
      burial_date: json['burial_date'] == '' ? 'غير مدرج' : json['burial_date'],
      shahed_number:
          json['shahed_number'] == '' ? 'غير مدرج' : json['shahed_number'],
      cemetery_name:
          json['cemetery_name'] == '' ? 'غير مدرج' : json['cemetery_name'],
    );
  }
}
