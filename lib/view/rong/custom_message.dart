import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
import 'dart:convert' as json;
import 'package:flutter_xyb/module/rong_enity.dart';

class ApprovalMessage extends MessageContent {
  static const String objectName = "MT:SYSMsg";

  //自定义的属性
  String content;
  String type;
  String reviewId;

  @override
  void decode(String jsonStr) {
    Map map = json.json.encode(jsonStr) as Map;
    content = map["content"];
    type = map["type"];
    reviewId = map["reviewId"];
    var contenBean = RongContenBean(content,type,reviewId);
  }

  @override
  String encode() {}

  @override
  String getObjectName() {
    return objectName;
  }

  @override
  String conversationDigest() {
    return content;
  }
}
