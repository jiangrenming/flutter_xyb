import 'package:flutter/material.dart';
import 'package:flutter_xyb/view/home/work_page.dart';
import 'package:flutter_xyb/view/home/message_page.dart';
import 'package:flutter_xyb/view/home/person_page.dart';
import 'package:flutter_xyb/view/home/contats_page.dart';
import 'package:flutter_xyb/constants/contants.dart';
import 'package:flutter_xyb/router/bundle_config.dart';
//首页
class MainPages extends StatefulWidget {

  final Bundle bundle;
   MainPages({this.bundle});

  @override
  State<StatefulWidget> createState() {
    return _MainPagesState();
  }
}

class _MainPagesState extends State<MainPages> {
  List<Widget> pages;
  int _currentIndex = 1;

  //底部tab数据和图标
  final itemsNames = [_Items("消息", "assets/images/icon_message_h.png", "assets/images/icon_message.png"),
    _Items("工作", "assets/images/icon_work_h.png", "assets/images/icon_work.png"),
    _Items("通讯录", "assets/images/icon_mail_list_h.png", "assets/images/icon_mail_list.png"),
    _Items("我的", "assets/images/icon_my_h.png", "assets/images/icon_my.png")];

  @override
  void initState() {
    super.initState();
    if (pages == null) {
       pages = [MessagePages(), WorkPages(), ConstansPages(), PersonPages()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   //   backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: itemsNames.map((item)=>BottomNavigationBarItem(
              icon: Image.asset(item.normalIcon,width: 25.0,height: 25.0,),
              title: Text(item.name,style: TextStyle(fontSize: 11.0),),
              activeIcon: Image.asset(item.activeIcon,width: 25.0,height: 25.0,
             ))).toList(),
        type: BottomNavigationBarType.fixed,
        fixedColor: Color.fromARGB(255, 0, 188, 96),
        iconSize: 24,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
//底部按钮的实体类
class _Items{
  String name, activeIcon, normalIcon;
  _Items(this.name, this.activeIcon, this.normalIcon);
}