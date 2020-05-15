import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_xyb/constants/contants.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_xyb/widgets/common_top.dart';
import 'package:flutter_xyb/http/dio_net.dart';
import 'package:flutter_xyb/base/response_entity.dart';
import 'package:flutter_xyb/module/perfrence_entity.dart';
import 'package:flutter_xyb/module/combina_entity.dart';
import 'package:flutter_xyb/widgets/loading_widget.dart';
import 'package:flutter_xyb/router/bundle_config.dart';

//绩效管理
class JXManager extends StatefulWidget {

  final Bundle bundle;
  JXManager({this.bundle});

  @override
  State<StatefulWidget> createState() {
    return _JXManagerStatue();
  }
}

class _JXManagerStatue extends State<JXManager> {
  String filePath = Constans.ASSETS_HTML + "echarts.html";
  WebViewController _webViewController;

  Future<String> _getFile() async {
    return await rootBundle.loadString(filePath);
  }

  PerfrenceEntity _mPerfrence;
  bool isComplete = false;
  String comBiaJson;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> params = new Map();
    params["custId"] = 226;
    DioApi.getInstance().post<HttpResponseEntity, PerfrenceEntity>(
        "/clinic/performance",
        params: params, sucessCallback: (response) {
      _mPerfrence = response;
      CombinaEntity combinaEntity = CombinaEntity();
      combinaEntity.allCount = _mPerfrence.summary;

      List<String> cfDate = List(); //处方时间
      List<int> cfCount = List(); //处方数量
      var cfByDays = _mPerfrence.cfByDays;
      int one = 0;
      if (null != cfByDays && cfByDays.isNotEmpty) {
        for (int i = 0; i < cfByDays.length; i++) {
          var date = cfByDays[i].date.split("-");
          cfDate.add(date[1] + "/" + date[2]);
          one = cfByDays[i].count;
          cfCount.add(cfByDays[i].count);
        }
        combinaEntity.cfDate = cfDate;
        combinaEntity.cfCount = cfCount;
      }
      List<String> jzDate = List(); //就诊日期
      List<int> jzCount = List(); //就诊数量
      var jzByDays = _mPerfrence.jzByDays;
      if (null != jzByDays && jzByDays.isNotEmpty) {
        for (int i = 0; i < jzByDays.length; i++) {
          var date = jzByDays[i].date.split("-");
          jzDate.add(date[1] + "/" + date[2]);
          jzCount.add(jzByDays[i].count);
        }
        combinaEntity.jzDate = jzDate;
        combinaEntity.jzCount = jzCount;
      }

      if (_mPerfrence.summary == 0) {
        combinaEntity.degs = 0;
      } else {
        combinaEntity.degs = (one / _mPerfrence.summary) * 100;
      }
      comBiaJson = jsonEncode(combinaEntity);
      isComplete = true;
    }, reLoginCallBack: (special) {}, errorCallback: (error) {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  color: Colors.white12,
                  child: CommonTopWidget(
                    "员工绩效",
                    mIsBackIcon: true,
                    mRightIcon: true,
                    mIcon: Icons.list,
                    onBack: (){
                     //Todo()路由器管理
                      Navigator.of(context).pop();
                    },
                    onRight: (){
                      //TodO()底部弹出窗

                    },
                  ),
                ),
                Expanded(
                  child: FutureBuilder<String>(
                      future: _getFile(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return WebView(
                            initialUrl: Uri.dataFromString(snapshot.data,
                                    mimeType: 'text/html',
                                    encoding: Encoding.getByName('utf-8'))
                                .toString(),
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated:
                                (WebViewController webViewController) {
                              _webViewController = webViewController;
                            },
                            onPageFinished: (String value) {
                              //页面加载完成
                              if (isComplete) {
                                _webViewController
                                    ?.evaluateJavascript('andData($comBiaJson)')
                                    ?.then((result) {
                                  //flutter调用js
                                });
                              }
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Scaffold(
                            body: Center(
                              child: Text("${snapshot.error}"),
                            ),
                          );
                        }
                        return Scaffold(
                          body: LoadingShimmerWidget(num: 5,),
                        );
                      }),
                )
              ],
            )));
  }
}
