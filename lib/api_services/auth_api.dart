import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_it;

class AuthApi {
  static final dio = Dio(
    BaseOptions(
      baseUrl: 'https://cemetery2.bmwit.com/api/',
      receiveDataWhenStatusError: true,
    ),
  );

  static void initializeInterceptors() {
    // dio.options.connectTimeout = 
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request, handler) {
        var headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        };

        request.headers.addAll(headers);
        // print('${request.method} ${request.path}');
        // print('${request.headers}');
        return handler.next(request); //continue
      },
      onResponse: (response, handler) {
        // print('${response.data}');
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

        return handler.next(error); //continue
      },
    ));
  } // end of initializeInterceptor

  static Future<Response> login(
      {required Map<String, dynamic> loginData}) async {
    FormData formData = FormData.fromMap(loginData);
    return dio.post('login', data: formData);
  } //end of login

  static Future<Response> getOtp({required String phone}) async {
    return dio.post('auth/create_otp', queryParameters: {'phone': phone});
  } //end of getServices

  static Future<Response> sendOtp(
      {required String code, required String phone}) async {
    return dio.post('auth/check_otp',
        queryParameters: {'verfication_code': code, 'phone': phone});
  } //end of getServices

  static Future<Response> clientRegister(
      {required Map<String, dynamic> registerData}) async {
    FormData formData = FormData.fromMap(registerData);
    return dio.post('auth/register', data: formData);
  } //end of register

  static Future<Response> getUser() async {
    return dio.get('/api/user');
  } //end of getUser

} //end of api
