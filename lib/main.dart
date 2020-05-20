import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_xyb/config/config.dart';
import 'package:flutter_xyb/config/app_config.dart';
import 'package:flutter_xyb/view/splash.dart';
import 'package:flutter/services.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart' as rongClound;
import 'package:fluttertoast/fluttertoast.dart';
import 'utils/share_utils.dart';
import 'package:flutter_xyb/router/router_config.dart';
import 'package:flutter_xyb/il10/l10n.dart';
import 'package:provider/provider.dart';
import 'package:flutter_xyb/provider/view_model/theme_module.dart';
import 'package:flutter_xyb/provider/view_model/locale_model.dart';
import 'package:flutter_xyb/provider/provider_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//开发环境的入口
void main() {
  Config.env = Env.DEV;
  AppConfig.apiBaseUrl = Config.apiHost;
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  realRunApp();
}

//初始化sp插件
void realRunApp() async {
  bool success = await SharedPreferencesDataUtils.init(); //初始化本地存储
  print("init-" + success.toString());
  RouterConfig.setupRouter(); //初始化配置路由管理器
  var appConfig = AppConfig(appName: "乡医宝", flavorName: "测试", child: MyApp());
  runApp(appConfig);
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MyAppStatue();
  }
}

class _MyAppStatue extends State<MyApp> {

  DateTime lastTime;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      //设置Android头部的导航栏透明
      SystemUiOverlayStyle style = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light);

      SystemChrome.setSystemUIOverlayStyle(style);

    } else if (Platform.isIOS) {
      //手机的状态栏默认为打开的
      //判断是否为苹果手机。如果是，并且padding top不为0即为x系列
      //其他系列关闭状态栏
      if (MediaQuery
          .of(context)
          .padding
          .top == null ||
          MediaQuery
              .of(context)
              .padding
              .top == 0) {
        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
      }
    }

    //初始化融云
    rongClound.RongcloudImPlugin.init("mgb7ka1nmdi2g");
    //收到融云消息
    /* rongClound.RongcloudImPlugin.onMessageReceivedWrapper =
        (rongClound.Message msg, int left, bool hasPackage, bool offline) {

        };*/
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: MultiProvider(
           providers: providers,
            child: Consumer2<ThemeModel, LocaleModel>(
              builder: (context, themeModel, localeModel, child){
                return  RefreshConfiguration(
                  hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
                    child: MaterialApp(
                      title: AppConfig
                          .of(context)
                          .appName,
                      debugShowCheckedModeBanner: false,
                      //theme darkTheme主要是操作 黑/白模式的切换
                      theme: themeModel.themeData(),
                      darkTheme: themeModel.themeData(platformDarkMode: true),
                      //本地语言国际化操作
                      locale: localeModel.locale,  //当前区域，如果为null则使用系统区域 一般用于语言切换
                      localizationsDelegates: [   // 本地化委托，用于更改Flutter Widget默认的提示语，按钮text等
                        S.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                        RefreshLocalizations.delegate, //下拉刷新
                      ],
                      supportedLocales: S.delegate.supportedLocales,  //传入支持的语种数组
                      //将路由器挂载在启动入口处
                      onGenerateRoute: RouterConfig.router.generator,
                      home: SplashPage(),
                    )
                );
              },
            ),
        ),
        onWillPop: () async {
          if (lastTime == null ||
              DateTime.now().difference(lastTime) > Duration(seconds: 1)) {
            lastTime = DateTime.now();
            Fluttertoast.showToast(
              msg: "双击退出程序",
              fontSize: 14,
              toastLength: Toast.LENGTH_SHORT,
            );
            return false;
          }
          return true;
        }
    );
  }
}
