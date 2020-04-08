import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart';
import 'package:flutter_xyb/http/callback.dart';
import 'package:flutter_xyb/http/error_net.dart';
import 'package:flutter_xyb/utils/net_check.dart';
import 'package:flutter_xyb/base/response_entity.dart';
import 'package:flutter_xyb/base/response_list_entity.dart';
import 'package:flutter_xyb/http/http_type.dart';

//封装网络请求 比如get post delete等
/**
 * T 表示返回的是否是集合，有HttpResponseEntity和HttpResponseListEntity两种
 * G 表示返回的是接口返回的类型（即你需要的类型）
 */

class ApiService{

  Dio dio;
  ApiService({this.dio});


  /**
   * get 请求体
   */
  Future<Observable> get<T,G>(String url, {Map<String, dynamic> params,
    HttpCallBack sucessCallback, HttpCallBack reLoginCallBack, HttpCallBack errorCallback,
      })async{
   return  Observable.fromFuture(_sendRequest<T,G>(url,HttpMethod.GET, sucessCallback,data: params,reLoginCallBack: reLoginCallBack,errorCallback: errorCallback)).asBroadcastStream();
  }

  /**
   * post 请求体
   */
  Future<Observable> post<T,G>(String url, {Map<String, dynamic> params,
    HttpCallBack sucessCallback, HttpCallBack reLoginCallBack, HttpCallBack errorCallback,
  })async{
    return  Observable.fromFuture(_sendRequest<T,G>(url,HttpMethod.POST, sucessCallback,data: params,reLoginCallBack: reLoginCallBack,errorCallback: errorCallback)).asBroadcastStream();
  }


  Future  _sendRequest<T,G>(
      String url,
      HttpMethod method,
      HttpCallBack sucessCallback,
      {
        Map<String, dynamic> data,
        HttpCallBack reLoginCallBack,
        HttpCallBack errorCallback
      })async{
    try{
      if(NetWorkCheck.isNetWorkAvailable() != 0){
        Response response;
        if(method == HttpMethod.GET){
          if(data == null  || data.isEmpty){
            response = await dio.get(url);
          }else{
            response = await dio.get(url,queryParameters: data);
          }
        }else{
          if(data == null  || data.isEmpty){
            response = await dio.post(url);
          }else{
            response = await dio.post(url,data: data);
          }
        }
        if(response.statusCode == 200){
          if (response.data['resultCode'] == "000") {
            _httpSuccess<T, G>(response.data, sucessCallback);
          } else {
            _httpSpecial(response.data, reLoginCallBack);
          }
        }else{
          _httpError(response.statusMessage, response.statusCode.toString(),errorCallback);
        }
      }else{
        _httpError( "暂无网络", ErrorException.NET_NONE,errorCallback);
      }
    }catch(e){
      _httpError(e.toString(),"1000" ,errorCallback);
    }
  }


  /**
   * 当statusCode ==200,和后台自定的code =000时 表示成功
   */
  _httpSuccess<T, G>(Map<String, dynamic> response, HttpCallBack  success) {
    if (success != null) {
      if (T.toString() == "HttpResponseEntity<dynamic>") {
        success((HttpResponseEntity<G>.fromJson(response).data));
      } else if (T.toString() == "HttpResponseListEntity<dynamic>") {
        success(HttpResponseListEntity<G>.fromJson(response).data);
      } else {
        success(response['message']);
      }
    }
  }

  ///statusCode==200 &&F lag!=000
  _httpSpecial(Map<String, dynamic> response, HttpCallBack reLoginCallBack) {
    ///可以针对不同的Flag 进行处理同一处理
    if (reLoginCallBack != null) {
      reLoginCallBack(response);
    } else {
      switch (response['resultCode']) {
        case "401":
          reLoginCallBack(LoginResponse("401", "token已失效,重新登陆").toJson()); //重新登陆
          break;
        default:
          Fluttertoast.showToast(
            msg: response['message'],
            fontSize: 14,
            toastLength: Toast.LENGTH_SHORT,
          );
      }
    }
  }
}

///statusCode!=200
_httpError(String errorMsg,String errorCode, HttpCallBack error) {
  print('httpError-----$errorMsg');
  if (error != null) {
    error(ErrorResponse(errorCode, errorMsg).toJson());
  }
}

class ErrorResponse {
  String message;
  String resultCode;
  ErrorResponse(this.message, this.resultCode);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['resultCode'] = this.resultCode;
    return data;
  }
}


class LoginResponse {
  String message;
  String resultCode;
  LoginResponse(this.message, this.resultCode);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['resultCode'] = this.resultCode;
    return data;
  }
}