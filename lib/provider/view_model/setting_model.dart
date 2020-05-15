import 'package:flutter/cupertino.dart';
import 'package:flutter_xyb/utils/share_utils.dart';

/// 使用原生WebView
const String kUseWebViewPlugin = 'kUseWebViewPlugin';
class UseWebViewPluginModel extends ChangeNotifier {
  get value =>
      SharedPreferencesDataUtils.getInstace().getbool(kUseWebViewPlugin) ?? false;

  switchValue(){
    SharedPreferencesDataUtils.getInstace()
        .setbool(kUseWebViewPlugin, !value);
    notifyListeners();
  }

}