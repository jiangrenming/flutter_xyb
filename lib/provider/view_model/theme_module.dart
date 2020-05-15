import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xyb/il10/l10n.dart';
import 'package:flutter_xyb/utils/share_utils.dart';
import 'package:flutter_xyb/provider/view_model/theme_helper.dart';

/**
 * 更换app主题theme为provider提供的中间层类
 */
class ThemeModel extends ChangeNotifier{

  static const kThemeColorIndex = 'kThemeColorIndex';
  static const kThemeUserDarkMode = 'kThemeUserDarkMode';
  static const kFontIndex = 'kFontIndex';
  static const fontValueList = ['system', 'kuaile'];
  /// 用户选择的明暗模式
  bool _userDarkMode;
  /// 当前主题颜色
  MaterialColor _themeColor;
  /// 当前字体索引
  int _fontIndex;

  ThemeModel() {
    /// 用户选择的明暗模式
    _userDarkMode =
        SharedPreferencesDataUtils.getInstace().getbool(kThemeUserDarkMode) ?? false;
    /// 获取主题色
    _themeColor = Colors.primaries[
    SharedPreferencesDataUtils.getInstace().getInt(kThemeColorIndex) ?? 5];
    /// 获取字体
    _fontIndex = SharedPreferencesDataUtils.getInstace().getInt(kFontIndex) ?? 0;
  }


  int get fontIndex => _fontIndex;


  /// 随机一个主题色彩
  /// 可以指定明暗模式,不指定则保持不变
  void switchRandomTheme({Brightness brightness}) {
    int colorIndex = Random().nextInt(Colors.primaries.length - 1);
    switchTheme(
      userDarkMode: Random().nextBool(),
      color: Colors.primaries[colorIndex],
    );
  }

  /// 切换指定色彩
  /// 没有传[brightness]就不改变brightness,color同理
  void switchTheme({bool userDarkMode, MaterialColor color}) {
    _userDarkMode = userDarkMode ?? _userDarkMode;
    _themeColor = color ?? _themeColor;
    notifyListeners();
    saveTheme2Storage(_userDarkMode, _themeColor);
  }

  /// 数据持久化到shared preferences
  saveTheme2Storage(bool userDarkMode, MaterialColor themeColor) async {
    var index = Colors.primaries.indexOf(themeColor);
    SharedPreferencesDataUtils.getInstace().setbool(kThemeUserDarkMode, userDarkMode);
    SharedPreferencesDataUtils.getInstace().setInt(kThemeColorIndex, index);
  }


  /// 切换字体
  switchFont(int index) {
    _fontIndex = index;
    switchTheme();
    SharedPreferencesDataUtils.getInstace().setInt(kFontIndex, index);
  }

  /// 根据主题 明暗 和 颜色 生成对应的主题
  /// [dark]系统的Dark Mode
  themeData({bool platformDarkMode: false}) {
    var isDark = platformDarkMode || _userDarkMode;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    var themeColor = _themeColor;
    var accentColor = isDark ? themeColor[700] : _themeColor;
    var themeData = ThemeData(
        brightness: brightness,
        // 主题颜色属于亮色系还是属于暗色系(eg:dark时,AppBarTitle文字及状态栏文字的颜色为白色,反之为黑色)
        // 这里设置为dark目的是,不管App是明or暗,都将appBar的字体颜色的默认值设为白色.
        // 再AnnotatedRegion<SystemUiOverlayStyle>的方式,调整响应的状态栏颜色
        primaryColorBrightness: Brightness.dark,
        accentColorBrightness: Brightness.dark,
        primarySwatch: themeColor,
        accentColor: accentColor,
        fontFamily: fontValueList[fontIndex]
    );

    themeData = themeData.copyWith(
        brightness: brightness,
        accentColor: accentColor,
        cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: themeColor,
        brightness: brightness,
      ),
      appBarTheme: themeData.appBarTheme.copyWith(elevation: 0),
      splashColor: themeColor.withAlpha(50),
      hintColor: themeData.hintColor.withAlpha(90),
      errorColor: Colors.red,
      cursorColor: accentColor,
      textTheme: themeData.textTheme.copyWith(
        /// 解决中文hint不居中的问题 https://github.com/flutter/flutter/issues/40248
          subhead: themeData.textTheme.subhead
              .copyWith(textBaseline: TextBaseline.alphabetic)),
      textSelectionColor: accentColor.withAlpha(60),
      textSelectionHandleColor: accentColor.withAlpha(60),
      toggleableActiveColor: accentColor,
      chipTheme: themeData.chipTheme.copyWith(
        pressElevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 10),
        labelStyle: themeData.textTheme.caption,
        backgroundColor: themeData.chipTheme.backgroundColor.withOpacity(0.1),
      ),
      inputDecorationTheme: ThemeHelper.inputDecorationTheme(themeData),
    );
    return themeData;
  }

  /// 根据索引获取字体名称,这里牵涉到国际化
  static String fontName(index, context) {
    switch (index) {
      case 0:
        return S.of(context).autoBySystem;
      case 1:
        return S.of(context).fontKuaiLe;
      default:
        return '';
    }
  }
}