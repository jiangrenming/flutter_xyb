import 'package:flutter_xyb/router/bundle_config.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
/**
 * 页面传参数的类
 */

typedef Widget HandlerFunc(BuildContext context,Map<String,List<String>> params);
typedef Widget PageBuilderFunc(Bundle bundle);


class PageBuilder {

  final PageBuilderFunc builder;
  HandlerFunc handlerFunc;
  PageBuilder({this.builder}){
    this.handlerFunc = (context,_){
      return this.builder(ModalRoute.of(context).settings.arguments as Bundle);
    };
  }

  Handler getHandler(){
    return Handler(handlerFunc: this.handlerFunc);
  }

}