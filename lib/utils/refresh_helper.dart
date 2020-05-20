import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xyb/il10/l10n.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_xyb/widgets/activity_indicator.dart';
import 'package:flutter_xyb/view/two_floor/home_second_floor_page.dart';

//pull-to-refresh的配置类
class HomeRefreshHeader  extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    var accentColor  =  Theme.of(context).accentColor;
    var strings = RefreshLocalizations.of(context)?.currentLocalization ?? EnRefreshString();
    return ClassicHeader(
      canTwoLevelText: S.of(context).refreshTwoLevel,
      textStyle: TextStyle(color: accentColor),
      outerBuilder: (child) => HomeSecondFloorOuter(child),
      twoLevelView: Container(),
      height: 70 + MediaQuery.of(context).padding.top / 3,
      refreshingIcon: ActivityIndicator(brightness: Brightness.dark),
      releaseText: strings.canRefreshText,
    );
  }

}

/// 通用的footer
/// 由于国际化需要context的原因,所以无法在[RefreshConfiguration]配置
class RefresherFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
//      failedText: S.of(context).loadMoreFailed,
//      idleText: S.of(context).loadMoreIdle,
//      loadingText: S.of(context).loadMoreLoading,
//      noDataText: S.of(context).loadMoreNoData,
    );
  }
}