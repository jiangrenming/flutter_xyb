import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_xyb/provider/view_model/locale_model.dart';
import 'package:flutter_xyb/provider/view_model/theme_module.dart';

/**
 * 所有provider共享都存放再providers数组中，进行初始化,创建工作
 */
List<SingleChildWidget> providers = [
  ...independentServices,
];

/// 独立的model
List<SingleChildWidget> independentServices = [

  //主题
  ChangeNotifierProvider<ThemeModel>(create: (context) {
    return ThemeModel();
  }),

  //语言国际化
  ChangeNotifierProvider<LocaleModel>(create: (context) {
    return LocaleModel();
  }),
];

