import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorException extends DioError{
  static const String DATA_NONE = "1001"; //数据为空
  static const String NET_NONE = "1002"; //无网络
  String errorCode;
  String errormessage;
  ErrorException({@required this.errorCode,@required this.errormessage});
}