// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Record.dart';

class ApiService {
  final String baseUrl = 'https://cemetery2.bmwit.com/api/cemetery_sites';

  Future<List<RecordModel>> fetchRecords() async {
    final response = await http.get(Uri.parse('$baseUrl/records'));
    print(response.body);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => RecordModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load records');
    }
  }

  Future<List<RecordModel>> searchRecords(String query, int page) async {
    final response = await http.get(
      Uri.parse('$baseUrl/records/search?search=$query&page=$page'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((data) => RecordModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load records');
    }
  }
}
