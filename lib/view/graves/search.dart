import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rheal/view/AppColors.dart';
import 'package:rheal/view/graves/RecordDetailScreen.dart';
import '../../api_services/htpp_api.dart';
import '../../models/Record.dart';
import '../appointments_screens/cemetery_detail.dart';
import 'grave.dart';

class Search extends StatefulWidget {
  @override
  _RecordListScreenState createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<Search> {
  final ApiService _apiService = ApiService();
  final ScrollController _scrollController = ScrollController();
  List<RecordModel> _records = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 1;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchRecords();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchMoreRecords();
      }
    });
  }

  Future<void> _fetchRecords() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<RecordModel> records = await _apiService.fetchRecords();
      setState(() {
        _records = records;
      });
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchMoreRecords() async {
    if (!_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      List<RecordModel> records =
          await _apiService.searchRecords(_searchQuery, _page + 1);
      setState(() {
        _page++;
        if (records.length < 10) {
          _hasMore = false;
        }
        _records.addAll(records);
      });
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _searchRecords(String query) async {
    setState(() {
      _isLoading = true;
      _searchQuery = query;
      _page = 1;
      _hasMore = true;
    });

    try {
      List<RecordModel> records = await _apiService.searchRecords(query, 1);
      setState(() {
        _records = records;
      });
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            decoration: InputDecoration(
              hintText: 'بحث...',
            ),
            onSubmitted: (query) {
              _searchRecords(query);
            },
          ),
        ),
        body: _isLoading && _records.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: AppColors.background,
                color: AppColors.text,
              ))
            : RefreshIndicator(
                backgroundColor: AppColors.background,
                color: AppColors.text,
                onRefresh: _fetchRecords,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _records.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _records.length) {
                      return _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : SizedBox.shrink();
                    }
                    RecordModel record = _records[index];
                    return ListTile(
                      title: Text(record.name ?? 'غير مدرج'),
                      subtitle: Text(record.cemetery_name ?? 'غير مدرج'),
                      onTap: () {
                        Get.to(RecordDetailScreen(
                          id: record.id,
                          emirates_id: record.emirates_id,
                          name: record.name,
                          gender: record.gender,
                          nationality: record.nationality,
                          cause_of_death: record.cause_of_death,
                          date_of_death: record.date_of_death,
                          hospital: record.hospital,
                          burial_date: record.burial_date,
                          cemetery_name: record.cemetery_name,
                          shahed_number: record.shahed_number,
                        ));
                      },
                    );
                  },
                ),
              ),
      ),
    );
  }
}
