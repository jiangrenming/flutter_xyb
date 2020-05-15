import 'package:flutter_xyb/router/page_builder.dart';
import 'package:flutter_xyb/view/login/login.dart';
import 'package:flutter_xyb/view/home/main_page.dart';
import 'package:flutter_xyb/view/home/emplomy/jx_manager.dart';

//页面名称枚举，添加页面在此添加一个枚举
enum PageName{
  login,
  home,
  jx_page
}

final Map<PageName,PageBuilder> pageRoutes = {
  PageName.login : PageBuilder(builder: (bundle) => LoginPages()),
  PageName.home : PageBuilder(builder: (bundle) =>MainPages (bundle: bundle)),
  PageName.jx_page : PageBuilder(builder: (bundle) =>JXManager (bundle: bundle)),

};
