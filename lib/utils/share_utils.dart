import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDataUtils {

  static SharedPreferences sharedPreferences;
  static SharedPreferencesDataUtils sharedPreferencesDataUtils;

  static Future<bool> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return true;
  }

  static SharedPreferencesDataUtils getInstace(){
    if(null == sharedPreferencesDataUtils){
      sharedPreferencesDataUtils = SharedPreferencesDataUtils();
    }
    return sharedPreferencesDataUtils;
  }

  int getInt(key) {
    var value = sharedPreferences.getInt(key);
    return value;
  }

  Future<int> setInt(key, value) {
    sharedPreferences.setInt(key, value);
  }

  String getString(key) {
    var string = sharedPreferences.getString(key);
    return string;
  }

  Future<String> setString(key, value) {
    sharedPreferences.setString(key, value);
  }

  bool getbool(key) {
    return sharedPreferences.getBool(key);
  }

  Future<bool> setbool(key, value) {
    sharedPreferences.setBool(key, value);
  }

  // 清除数据
  Future deleteInfos(key) {
    sharedPreferences.remove(key);
  }
}
