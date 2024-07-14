// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_it;
import 'package:get_storage/get_storage.dart';

class Api {
  static final dio = Dio(
    BaseOptions(
      baseUrl: 'https://cemetery2.bmwit.com/api/',
      receiveDataWhenStatusError: true,
    ),
  );

  static void initializeInterceptors() {
    // dio.options.connectTimeout = 5000 as Duration?;
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request, handler) async {
        var token = await GetStorage().read('login_token');

        var headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'contentTypeHeader': 'application/json',
          'Authorization': 'Bearer $token',
        };

        request.headers.addAll(headers);
        print('${request.method} ${request.path}');
        print('${request.headers}');
        return handler.next(request); //continue
      },
      onResponse: (response, handler) {
        print('${response.data}');
        if (response.data['error'] == 1) throw response.data['message'];

        return handler.next(response); // continue
      },
      onError: (error, handler) {
        if (get_it.Get.isDialogOpen == true) {
          get_it.Get.back();
        }
        get_it.Get.snackbar(
          'خطأ',
          'هنالك خطأ في الإتصال',
          snackPosition: get_it.SnackPosition.BOTTOM,
          colorText: Colors.black,
        );
        // GET.Get.snackbar(
        //   'error'.tr,
        //   '${error.message}',
        //   snackPosition: GET.SnackPosition.BOTTOM,
        //   colorText: Colors.black,
        // );

        return handler.next(error); //continue
      },
    ));
  } // end of initializeInterceptor

  static Future<Response> getCategories() async {
    return dio.post('libarary/get-libarares');
  } //end of getcateguries

  static Future<Response> getNews() async {
    return dio.post('news/get-news');
  } //end of getcateguries

  static Future<Response> getProject() async {
    return dio.post('Project/get-Project');
  } //end of getcateguries

  static Future<Response> getabout() async {
    return dio.post(
        'AboutTheOfficeOfCemeteriesAffair/get-AboutTheOfficeOfCemeteriesAffair');
  } //end of getcateguries

  static Future<Response> getDeaths() async {
    return dio.post('getDailyDeath/get-getDailyDeath');
  } //end of getcateguries

  static Future<Response> getServices({required int catId}) async {
    return dio.get('libarary/get-libarary/${catId}');
  } //end of getServices

  static Future<Response> getSettings({required String key}) async {
    return dio.get('setting/get-lsetting/${key}');
  } //end

  static Future<Response> getCemeteryDetail({required int id}) async {
    return dio.get('cemetery_sites/get_cemetery_detail/${id}');
  } //end

  static Future<Response> getGrave({required int id}) async {
    return dio.get('cemetery_sites/get_grave/${id}');
  } //end

  static Future<Response> getLibararyMedia(
      {required int id, required String type}) async {
    return dio.get('libarary/get-libarary/${id}/${type}');
  } //end

  static Future<Response> getNewsMedia(
      {required int id, required int type}) async {
    return dio.get('news/get-news/${id}/${type}');
  } //end

  static Future<Response> getProjectMedia(
      {required int id, required int type}) async {
    return dio.get('Project/get-Project/${id}/${type}');
  } //end

  static Future<Response> getAboutMedia(
      {required int id, required int type}) async {
    return dio.get(
        'AboutTheOfficeOfCemeteriesAffair/get-AboutTheOfficeOfCemeteriesAffair/${id}/${type}');
  } //end

  static Future<Response> getCemetery(
      {required int id, required int type}) async {
    return dio.get('cemetery_sites/get-cemetery-site/${id}/${type}');
  } //end

  static Future<Response> getLibararyTextMedia(
      {required int id, required String type}) async {
    return dio.get('libarary/get-libarary/${id}/${type}');
  } //end

  static Future<Response> getLibararyVoiceMedia(
      {required int id, required String type}) async {
    return dio.get('libarary/get-libarary/${id}/${type}');
  } //end

  static Future<Response> getLibararyVideoMedia(
      {required int id, required String type}) async {
    return dio.get('libarary/get-libarary/${id}/${type}');
  } //end

  static Future<Response> getNewsVideoMedia(
      {required int id, required int type}) async {
    return dio.get('news/get-news/${id}/${type}');
  } //end

  static Future<Response> getProjectVideoMedia(
      {required int id, required int type}) async {
    return dio.get('Project/get-Project/${id}/${type}');
  } //end

  static Future<Response> getAboutVideoMedia(
      {required int id, required int type}) async {
    return dio.get(
        'AboutTheOfficeOfCemeteriesAffair/get-AboutTheOfficeOfCemeteriesAffair/${id}/${type}');
  } //end

  static Future<Response> getNotifcation() async {
    return dio.get('setting/get-notifications');
  } //end of

  static Future<Response> getAllServices() async {
    return dio.get('services/all');
  } //end of getServices

  static Future<Response> getConsle({required int serviceId}) async {
    return dio.post('service/consoles', data: {'service_id': serviceId});
  } //end of getConsoles

  static Future<Response> orderCreate(
      {required Map<String, dynamic> orderData}) async {
    FormData formData = FormData.fromMap(orderData);
    return dio.post('orders/create', data: formData);
  } //end of orderCreate

  static Future<Response> getConsoleOrders() async {
    return dio.post('console/orders');
  } //end of getConsoleOrders

  static Future<Response> getcemeteryContacs(int id) async {
    return dio.get('cemetery_sites/get-cemetery-site-contact/${id}');
  } //end of getServices

  static Future<Response> clientOrders() async {
    return dio.post('cemetery_sites/get-cemetery-sites');
  } //end of getConsoleOrders

  static Future<Response> activeOrder({required int orderId}) async {
    return dio.post('orders/confirm', data: {'order_id': orderId});
  } //end of activeOrder

  static Future<Response> getUser() async {
    return dio.get('user/get-user');
  } //end of getUser
} //end of api
