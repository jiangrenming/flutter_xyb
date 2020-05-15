import 'package:flutter/material.dart';
import 'package:flutter_xyb/module/work_team_bean_entity.dart';
import 'package:flutter_xyb/utils/share_utils.dart';
import 'package:flutter_xyb/constants/contants.dart';
import 'dart:convert';
class HomeTopWidgets extends StatefulWidget {
  final List<WorkTeamBeanLevel> data;

  HomeTopWidgets({this.data});

  @override
  State<StatefulWidget> createState() {
    return _HomeTopWidgetsState();
  }
}

class _HomeTopWidgetsState extends State<HomeTopWidgets> {
  bool isNoData = true;
  String words = "";

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      isNoData = false;
    } else {
      int role = SharedPreferencesDataUtils.getInstace().getInt(Constans.ROLEID);
      for (int i = 0; i < widget.data.length; i++) {
        if (role == widget.data[i].roleId) {
          SharedPreferencesDataUtils.getInstace().setInt(Constans.TEAM_TYPE, widget.data[i].levelId);//类型，1:省代，2:市代，3:县代，4:乡代，5:诊所
          SharedPreferencesDataUtils.getInstace().setInt(Constans.ROLEID, widget.data[i].roleId);
          SharedPreferencesDataUtils.getInstace().setString(Constans.TEAM, jsonEncode(widget.data[i]));
          if (widget.data[i].roleId == 2) {
            words = "内勤";
          } else if (widget.data[i].roleId == 3) {
            words = "学术";
          } else if (widget.data[i].roleId == 8) {
            words = "医生";
          } else if (widget.data[i].roleId == 9) {
            words = "护士";
          } else if (widget.data[i].roleId == 10) {
            words = "财务";
          }
          if (words.isEmpty) {
            words = widget.data[i].companyName + "-" + widget.data[i].levelName;
          } else {
            words = widget.data[i].companyName +
                "-" +
                widget.data[i].levelName +
                "-" +
                words;
          }
        }
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      color: Colors.white12,
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                child: Offstage(
                  offstage: !isNoData,
                  child:GestureDetector(
                    onTap: (){
                      //TOdO()下拉框
                    },
                    child:Row(
                      children: <Widget>[
                        Text(words),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ) ,
                  )
                )),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
              child: Icon(Icons.playlist_add),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
