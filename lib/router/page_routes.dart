import 'package:flutter_xyb/router/page_builder.dart';
import 'package:flutter_xyb/view/login/login.dart';
import 'package:flutter_xyb/view/home/main_page.dart';
import 'package:flutter_xyb/view/home/emplomy/jx_manager.dart';
import 'package:flutter_xyb/view/home/person/setting_page.dart';
import 'package:flutter_xyb/view/two_floor/home_second_floor_page.dart';

//页面名称枚举，添加页面在此添加一个枚举
enum PageName{
  login,
  home,
  jx_page,
  setting,
  two_floor,
}

final Map<PageName,PageBuilder> pageRoutes = {
  PageName.login : PageBuilder(builder: (bundle) => LoginPages()),
  PageName.home : PageBuilder(builder: (bundle) =>MainPages (bundle: bundle)),
  PageName.jx_page : PageBuilder(builder: (bundle) =>JXManager (bundle: bundle)),
  PageName.setting : PageBuilder(builder: (bundle) =>SettingPages ()),
  PageName.two_floor : PageBuilder(builder: (bundle) =>MyBlogPage()),
};
