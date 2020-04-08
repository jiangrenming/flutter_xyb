import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDataUtils{


  static SharedPreferencesDataUtils _sharedPreferencesDataUtils;

  static SharedPreferencesDataUtils getInstance(){
    if(_sharedPreferencesDataUtils == null){
      _sharedPreferencesDataUtils = SharedPreferencesDataUtils();
    }
    return _sharedPreferencesDataUtils;
  }


  Future<String> getString(key) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var string = sharedPreferences.getString(key);
    return string;
  }

  Future<String> setString(key,value) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key,value);
  }


  Future<bool> getbool(key) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }

  Future<bool> setbool(key,value) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(key,value);
  }

  // 清除数据
  Future deleteInfos(key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }

}