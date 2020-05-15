import 'package:flutter/material.dart';
import 'dart:ui' as ui;

///默认设计稿尺寸（单位 dp or pt）
double _designW = 360.0;
double _designH = 640.0;
double _designD = 3.0;


/**
 * 配置设计稿尺寸（单位 dp or pt）
 * w 宽
 * h 高
 * density 像素密度
 */
void setDesignWHD(double w, double h, {double density = 3.0}) {
  _designW = w;
  _designH = h;
  _designD = density;
}

class AndroidUtils {

  double _screenWidth = 0.0;
  double _screenHeight = 0.0;
  double _screenDensity = 0.0;
  double _statusBarHeight = 0.0;
  double _bottomBarHeight = 0.0;
  double _appBarHeight = 0.0;

  MediaQueryData _mediaQueryData;

  static AndroidUtils _singlton = AndroidUtils();
  static AndroidUtils getInstance(){
    _singlton._init();
    return _singlton;
  }

  _init(){
    var queryData = MediaQueryData.fromWindow(ui.window);
    if(queryData != _mediaQueryData){
      _mediaQueryData = queryData;
      _screenWidth = queryData.size.width;
      _screenHeight = queryData.size.height;
      _screenDensity = queryData.devicePixelRatio;
      _bottomBarHeight = queryData.padding.bottom;
      _statusBarHeight = queryData.padding.top;
      _appBarHeight = kToolbarHeight;
    }
  }

  MediaQueryData get mediaQueryData => _mediaQueryData;

  double get appBarHeight => _appBarHeight;

  double get bottomBarHeight => _bottomBarHeight;

  double get statusBarHeight => _statusBarHeight;

  double get screenDensity => _screenDensity;

  double get screenHeight => _screenHeight;

  double get screenWidth => _screenWidth;

  /// 当前屏幕 宽
  static double screenW(BuildContext context) {
    MediaQueryData  queryData = MediaQuery.of(context);
    return queryData.size.width;
  }
  /// 当前屏幕 高
  static double screenH(BuildContext context) {
    MediaQueryData  queryData = MediaQuery.of(context);
    return queryData.size.height;
  }
  /// 当前屏幕  像素密度
  static double getScreenDensity(BuildContext context) {
    MediaQueryData  queryData = MediaQuery.of(context);
    return queryData.devicePixelRatio;
  }
  /// 当前状态栏高度
  static double getStatusBarH(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.padding.top;
  }
  /// 当前BottomBar高度
  static double getBottomBarH(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.padding.bottom;
  }

  /// 当前MediaQueryData
  static MediaQueryData getMediaQueryData(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery;
  }

  /// 返回根据屏幕宽适配后尺寸（单位 dp or pt）
  /// size 单位 dp or pt
  static double getScaleW(BuildContext context, double size) {
    if (context == null || screenW(context) == 0.0) return size;
    return size * screenW(context) / _designW;
  }
  /// 返回根据屏幕高适配后尺寸 （单位 dp or pt）
  /// size unit dp or pt
  static double getScaleH(BuildContext context, double size) {
    if (context == null || screenH(context) == 0.0) return size;
    return size * screenH(context) / _designH;
  }

  /// 返回根据屏幕宽适配后字体尺寸
  /// fontSize 字体尺寸
  static double getScaleSp(BuildContext context, double fontSize) {
    if (context == null || getScreenDensity(context) == 0.0) return fontSize;
    return fontSize * screenW(context) / _designW;
  }

  /// 设备方向(portrait, landscape)
  static Orientation getOrientation(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.orientation;
  }

  /// 返回根据屏幕宽适配后尺寸（单位 dp or pt）
  /// size 单位 dp or pt
  double getWidth(double size) {
    return _screenWidth == 0.0 ? size : (size * _screenWidth / _designW);
  }

  /// 返回根据屏幕高适配后尺寸（单位 dp or pt）
  /// size unit dp or pt
  double getHeight(double size) {
    return _screenHeight == 0.0 ? size : (size * _screenHeight / _designH);
  }

  // 返回根据屏幕宽适配后尺寸（单位 dp or pt）
  double getWidthPx(double sizePx) {
    return _screenWidth == 0.0
        ? (sizePx / _designD)
        : (sizePx * _screenWidth / (_designW * _designD));
  }

  /// 返回根据屏幕高适配后尺寸（单位 dp or pt）
  double getHeightPx(double sizePx) {
    return _screenHeight == 0.0
        ? (sizePx / _designD)
        : (sizePx * _screenHeight / (_designH * _designD));
  }
  /// 返回根据屏幕宽适配后字体尺寸
  double getSp(double fontSize) {
    if (_screenDensity == 0.0) return fontSize;
    return fontSize * _screenWidth / _designW;
  }




}