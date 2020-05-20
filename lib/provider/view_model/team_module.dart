import 'package:flutter/material.dart';
import 'package:flutter_xyb/module/work_team_bean_entity.dart';
import 'package:flutter_xyb/utils/share_utils.dart';
import 'dart:convert';

class TeamModule extends ChangeNotifier{
  static const String kTeam = 'kTeam';
  WorkTeamBeanLevel _workTeamBeanLevel;

  bool get hasTeam => _workTeamBeanLevel != null;
  WorkTeamBeanLevel get () => _workTeamBeanLevel == null ? WorkTeamBeanLevel() : _workTeamBeanLevel;

  TeamModule(){
    var teamMap ;
    var team = SharedPreferencesDataUtils.getInstace().getString(kTeam);
    if(null != team){
      teamMap = json.decode(team);
    }
    _workTeamBeanLevel = teamMap != null ? WorkTeamBeanLevel.fromJson(teamMap) : null;

  }


  saveTeam(WorkTeamBeanLevel teamBeanLevel) {
    _workTeamBeanLevel = teamBeanLevel;
    notifyListeners();
    SharedPreferencesDataUtils.getInstace().setString(kTeam, json.encode(_workTeamBeanLevel));
  }

  /// 清除持久化的用户数据
  clearUser() {
    _workTeamBeanLevel = null;
    notifyListeners();
    SharedPreferencesDataUtils.getInstace().deleteInfos(kTeam);
  }





}