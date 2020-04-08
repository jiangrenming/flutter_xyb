
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
class Md5Utils {

  //md5加密
  static String generateMd5(String value){
    if(value == null){
      return "";
    }
    var uint8list = Utf8Encoder().convert(value);
    var digest = md5.convert(uint8list);
    return hex.encode(digest.bytes);
  }


}