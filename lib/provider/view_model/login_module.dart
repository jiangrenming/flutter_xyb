import 'package:flutter/material.dart';
import 'package:flutter_xyb/module/login_entity.dart';
import 'package:flutter_xyb/utils/share_utils.dart';
import 'dart:convert';

/**
 * 登陆数据持久化，provider中间层
 */
class LoginModule extends ChangeNotifier{

  static const String kUser = 'kUser';
  LoginEntity _loginEntity;


  bool get hasUser => _loginEntity != null;
  LoginEntity get () => _loginEntity;

  LoginModule() {
    var userMap = json.decode(SharedPreferencesDataUtils.getInstace().getString(kUser));
    _loginEntity = userMap != null ? LoginEntity.fromJson(userMap) : null;
  }

  saveUser(LoginEntity user) {
    _loginEntity = user;
    notifyListeners();
    SharedPreferencesDataUtils.getInstace().setString(kUser, json.encode(user));
  }

  /// 清除持久化的用户数据
  clearUser() {
    _loginEntity = null;
    notifyListeners();
    SharedPreferencesDataUtils.getInstace().deleteInfos(kUser);
  }



}