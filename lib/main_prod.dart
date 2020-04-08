import 'package:flutter_xyb/config/config.dart';
import 'package:flutter_xyb/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter_xyb/view/splash.dart';

//生产环境的入口
void main() {
  Config.env = Env.PROD;
  var appConfig = AppConfig(appName: "乡医宝", flavorName: "线上" , child:  MyApp());
  AppConfig.apiBaseUrl = Config.apiHost;
  runApp(appConfig);
  if(Platform.isAndroid) {
    //设置Android头部的导航栏透明
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.of(context).appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
