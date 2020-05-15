import 'package:flutter/material.dart';
import 'package:flutter_xyb/il10/l10n.dart';
import 'package:flutter_xyb/utils/share_utils.dart';

/**
 * 国际化语言 provide中间层类
 */
class LocaleModel extends ChangeNotifier {

  static const localeValueList = ['', 'zh-CN', 'en'];
  static const kLocaleIndex = 'kLocaleIndex';
  int _localeIndex;
  int get localeIndex => _localeIndex;

  Locale get locale {
    if (_localeIndex > 0) {
      var value = localeValueList[_localeIndex].split("-");
      return Locale(value[0], value.length == 2 ? value[1] : '');
    }
    // 跟随系统
    return null;
  }

  LocaleModel() {
    _localeIndex =SharedPreferencesDataUtils.getInstace().getInt(kLocaleIndex) ?? 0;
  }

  switchLocale(int index) {
    _localeIndex = index;
    notifyListeners();
    SharedPreferencesDataUtils.getInstace().setInt(kLocaleIndex, index);
  }

  static String localeName(index, context) {
    switch (index) {
      case 0:
        return S.of(context).autoBySystem;
      case 1:
        return '中文';
      case 2:
        return 'English';
      default:
        return '';
    }
  }
}
