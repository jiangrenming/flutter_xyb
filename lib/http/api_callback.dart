
import 'package:dio/dio.dart';
import 'package:flutter_xyb/utils/share_utils.dart';
import 'package:flutter_xyb/constants/contants.dart';

class ResponseWrapper extends InterceptorsWrapper{


 /* @override
   onRequest(RequestOptions options) {
    Map<String, String> headers = new Map();
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
  }*/



}