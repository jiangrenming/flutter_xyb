import 'package:flutter/material.dart';
import 'package:flutter_xyb/module/work_team_bean_entity.dart';
import 'package:flutter_xyb/utils/share_utils.dart';
import 'dart:convert';

class TeamModule extends ChangeNotifier{
  static const String kTeam = 'kTeam';
  WorkTeamBeanLevel _workTeamBeanLevel;

  bool get hasTeam => _workTeamBeanLevel != null;
  WorkTeamBeanLevel get () => _workTeamBeanLevel;

  TeamModule(){

    var team = json.decode(SharedPreferencesDataUtils.getInstace().getString(kTeam));
    _workTeamBeanLevel = team != null ? WorkTeamBeanLevel.fromJson(team) : null;

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