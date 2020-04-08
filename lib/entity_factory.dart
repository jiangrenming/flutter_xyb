import 'package:flutter_xyb/base/response_entity.dart';
import 'package:flutter_xyb/base/response_list_entity.dart';
import 'package:flutter_xyb/module/login_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "HttpResponseEntity") {
      return HttpResponseEntity.fromJson(json) as T;
    } else if (T.toString() == "HttpResponseListEntity") {
      return HttpResponseListEntity.fromJson(json) as T;
    } else if (T.toString() == "LoginEntity") {
      return LoginEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}