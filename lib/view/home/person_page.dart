import 'package:flutter/material.dart';
import 'package:flutter_xyb/il10/l10n.dart';
import 'package:flutter_xyb/provider/provider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_xyb/provider/view_model/theme_module.dart';
import 'package:flutter_xyb/provider/view_model/locale_model.dart';
import 'package:flutter_xyb/provider/view_model/setting_model.dart';
import 'package:flutter_xyb/provider/view_model/login_module.dart';
import 'package:flutter_xyb/widgets/bottom_clipper.dart';
import 'package:flutter_xyb/constants/contants.dart';
import 'package:flutter_xyb/provider/view_model/team_module.dart';
import 'package:flutter_xyb/router/page_routes.dart';
//个人中心
/**
 * AutomaticKeepAliveClientMixin 相当于切换tab 不重新调用initState，从而保持之前的状态，不耗内存，只有当wisget是StatefulWidget时才可用
 * wantKeepAlive 返回true
 */
class PersonPages extends StatefulWidget {
  @override
  _UserPageState createState() {
    return _UserPageState();
  }
}

class _UserPageState extends State<PersonPages>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    print("哈哈哈哈哈哈");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); //这句一定要添加，不然有时候不起作用
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: 200 + MediaQuery.of(context).padding.top,
            flexibleSpace: UserHeaderWidget(),
            pinned: false,
          ),
          SearchTeam(),
          UserListWidget(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/**
 * 我的团队布局
 */
class SearchTeam extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return ProviderWidget2<LoginModule,TeamModule>(
       model1: LoginModule(),
       model2: TeamModule(),
       builder: (ctx,module1,module2,child){
         return ListTileTheme(
           contentPadding: const EdgeInsets.symmetric(horizontal: 30),
           child:  SliverList(
               delegate: SliverChildListDelegate([
                 ListTile(
                   title: Text(S.of(context).myteam,style: TextStyle(fontSize: 18.0),),
                 ),
                 ListTile(
                   title: Text((module1.hasUser && module1.get().roleId == 0) ? "我的团队或诊所" :
                   ( module1.get().roleId != 0 && module2.get().levelId != 5) ? "我的团队":"我的诊所",style: TextStyle(fontSize: 15.0),),
                 ),
                 Offstage(
                   offstage:(module1.hasUser && module1.get().roleId == 0),
                   child: ListTile(
                       title: Text((module2.get().roleId != 0 && module2.get().levelId != 5) ? "查看我的团队":"查看我的诊所",style: TextStyle(fontSize: 12.0),),
                   ),
                 )
               ])
           ),
         );
       },
     );
  }
}

/**
 * 顶部布局：有关头像
 */
class UserHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomClipper(),
      child: Container(
        color: Theme.of(context).primaryColor.withAlpha(200),
        padding: EdgeInsets.only(top: 10),
        child: ProviderWidget(
          model: LoginModule(),
          builder: (ctx, module, child) {
            return InkWell(
              onTap: () {
                //tODo()更换头像
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Hero(
                        tag: "loginLogo",
                        child: ClipOval(
                          child: module.hasUser
                              ? Image.network(module.get().imageUrl,
                                  fit: BoxFit.cover,
                                  width: 80.0,
                                  height: 80.0,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withAlpha(200),
                                  colorBlendMode: BlendMode.colorDodge)
                              : Image.asset(Constans.ASSETS_IMG + "icon_my.png",
                                  fit: BoxFit.cover,
                                  width: 80.0,
                                  height: 80.0,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withAlpha(10),
                                  colorBlendMode: BlendMode.colorDodge),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          module.hasUser
                              ? module.get().phone
                              : S.of(context).toSignIn,
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .apply(color: Colors.white.withAlpha(200))),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/**
 * 列表
 */
class UserListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;
    return ProviderWidget<TeamModule>(
      model: TeamModule(),
      builder: (ctx, module, child) {
        return ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          child: SliverList(
            delegate: SliverChildListDelegate([
              Offstage(
                offstage: (module.hasTeam &&
                    (module.get().roleId == 0 || module.get().levelId != 5)),
                child: ListTile(
                  title: Text(S.of(context).myauthorization),
                  leading:
                      Image.asset(Constans.ASSETS_IMG + "icon_my_auth.png",width: 20.0,height: 20.0,fit: BoxFit.cover,color: iconColor),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    //ToDo()进入我的授权界面
                  },
                ),
              ),
              Offstage(
                offstage: !(module.hasTeam &&
                    (module.get().roleId == 0 || module.get().levelId == 5)),
                child: ListTile(
                  title: Text(S.of(context).mypaints),
                  leading: Image.asset(Constans.ASSETS_IMG + "icon_my_hz.png",width: 20.0,height: 20.0,fit: BoxFit.cover,color: iconColor),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    //ToDo()进入我的患者界面
                  },
                ),
              ),
              ListTile(
                title: Text(S.of(context).myservice),
                leading:
                    Image.asset(Constans.ASSETS_IMG + "icon_my_customer.png",width: 20.0,height: 20.0,fit: BoxFit.cover,color: iconColor),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  //ToDo()进入我的客服
                },
              ),
              ListTile(
                title: Text(S.of(context).myadvice),
                leading:
                    Image.asset(Constans.ASSETS_IMG + "icon_my_feed_back.png",width: 20.0,height: 20.0,fit: BoxFit.cover,color: iconColor),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  //ToDo()进入意见反馈
                },
              ),
              ListTile(
                //切换黑夜模式
                title: Text(S.of(context).darkMode),
                onTap: () {
                  switchDarkMode(context);
                },
                leading: Transform.rotate(
                  angle: -10,
                  child: Icon(
                    Theme.of(context).brightness == Brightness.light
                        ? Icons.brightness_5
                        : Icons.brightness_2,
                    color: iconColor,
                  ),
                ),
                trailing: CupertinoSwitch(
                    activeColor: Theme.of(context).accentColor,
                    value: Theme.of(context).brightness == Brightness.dark,
                    onChanged: (value) {
                      switchDarkMode(context);
                    }),
              ),
              SettingThemeWidget(), //主题色彩
              ListTile(
                title: Text(S.of(context).setting),
                onTap: () {
                  //ToDo()进入设置界面
                  Navigator.of(context).pushNamed(PageName.setting.toString());
                },
                leading: Icon(
                  Icons.settings,
                  color: iconColor,
                ),
                trailing: Icon(Icons.chevron_right),
              ),
            ]),
          ),
        );
      },
    );
  }

  void switchDarkMode(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      Fluttertoast.showToast(
        msg: "检测到系统为暗黑模式,已为你自动切换",
        fontSize: 14,
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Provider.of<ThemeModel>(context, listen: false).switchTheme(
          userDarkMode: Theme.of(context).brightness == Brightness.light);
    }
  }
}

/**
 * 主题色彩切换
 */
class SettingThemeWidget extends StatelessWidget {
  SettingThemeWidget();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(S.of(context).theme),
      leading: Icon(
        Icons.color_lens,
        color: Theme.of(context).accentColor,
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: <Widget>[
              ...Colors.primaries
                  .map((color) => Material(
                        color: color,
                        child: InkWell(
                          onTap: () {
                            var model =
                                Provider.of<ThemeModel>(context, listen: false);
                            model.switchTheme(color: color);
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                          ),
                        ),
                      ))
                  .toList(),
              Material(
                child: InkWell(
                  onTap: () {
                    var model = Provider.of<ThemeModel>(context, listen: false);
                    var brightness = Theme.of(context).brightness;
                    model.switchRandomTheme(brightness: brightness);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).accentColor)),
                    width: 40,
                    height: 40,
                    child: Text(
                      "?",
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
