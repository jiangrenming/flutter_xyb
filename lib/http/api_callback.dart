
import 'package:dio/dio.dart';
import 'package:flutter_xyb/utils/share_utils.dart';
import 'package:flutter_xyb/constants/contants.dart';

class ResponseWrapper extends InterceptorsWrapper{

  String token;

  @override
   onRequest(RequestOptions options) {
    Map<String, String> headers = new Map();
    headers["clientType"] = "Android";
    SharedPreferencesDataUtils.getInstance().getString(Constans.TOKEN).then((String t) =>{
      token = t
    });
    if(token != null){
      headers["Authorization"] = token;
    }
    headers["Authorization"] = "";
    options.headers = headers;
    return options;
  }
}