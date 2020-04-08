import 'package:flutter/material.dart';
//全局环境配置
class AppConfig extends InheritedWidget{

  final String appName;
  final String flavorName;
  static String _apiBaseUrl;


  static set apiBaseUrl(String value) {
    _apiBaseUrl = value;
  }

  static String get apiBaseUrl => _apiBaseUrl;

  AppConfig({
    @required this.appName,
    @required this.flavorName,
    @required Widget child,
  }) : super(child: child);


  static AppConfig of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppConfig);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }


}