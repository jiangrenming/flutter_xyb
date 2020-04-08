import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_xyb/http/api_service.dart';
import 'package:flutter_xyb/http/api_callback.dart';
import 'package:flutter_xyb/config/app_config.dart';

//dio框架的封装

class DioApi{


  static ApiService apiService;
  static DioApi instance;

  DioApi(){
   var options =  BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      baseUrl: AppConfig.apiBaseUrl,
      contentType: ContentType("application","json",charset: "utf-8"),
   );

    Dio dio = new Dio(options);
   dio.interceptors.add(ResponseWrapper());  //添加header头部
   dio.interceptors.add(LogInterceptor(request: true,responseBody: true)); //日志打印拦截器
   apiService = ApiService(dio: dio);

  }

  static ApiService getInstance(){
    if(instance == null){
      instance = DioApi();
    }
    return _getService();
  }

  static ApiService _getService(){
    return apiService;
  }
}

