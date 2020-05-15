import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_xyb/http/api_service.dart';
import 'package:flutter_xyb/config/app_config.dart';
import 'package:flutter_xyb/utils/share_utils.dart';
import 'package:flutter_xyb/constants/contants.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:dio/adapter.dart';
//dio框架的封装

class DioApi{

 final String PEM ="";//证书内容
  static ApiService apiService;
  static DioApi instance;

  DioApi(){
   var options =  BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      baseUrl: AppConfig.apiBaseUrl,
      headers: httpHeaders,
   );

    Dio dio = new Dio(options);
   dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options){
     Map<String, dynamic> headers =  options.headers;
     headers["clientType"] = "Android";
     String token  =  SharedPreferencesDataUtils.getInstace().getString(Constans.TOKEN);
     if(token != null){
       print("token=" + token);
       headers["Authorization"] = token;
     }else{
       headers["Authorization"] = "";
     }
     options.headers = headers;
     return options;
   }));
   dio.interceptors.add(LogInterceptor(request: true,responseBody: true)); //日志打印拦截器
  /* var adapter  = DefaultHttpClientAdapter();
   adapter.onHttpClientCreate = (HttpClient client){
     client.badCertificateCallback=(X509Certificate cert, String host, int port){
       if(cert.pem == PEM){ // 证书一致，则放行
         return true;
       }
       return false;
     };
   };
   dio.httpClientAdapter = adapter;*/
   apiService = ApiService(dio: dio);
  }


  /// 自定义Header
  Map<String, dynamic> httpHeaders = {
    'Accept': 'application/json,*/*',
    'Content-Type': 'application/json',
  };

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

