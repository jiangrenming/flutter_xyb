
import 'package:flutter_xyb/entity_factory.dart';
class HttpResponseListEntity<T>{

  T data;
  String message;
  String resultCode;

  HttpResponseListEntity({this.data, this.message, this.resultCode});

  HttpResponseListEntity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<T>() as T;
      (json['data'] as List).forEach((v) {
        (data as List).add(EntityFactory.generateOBJ<T>(v));
      });
    }
    message = json['message'];
    resultCode = json['resultCode'];
  }
}