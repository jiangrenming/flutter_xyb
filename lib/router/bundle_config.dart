/**
 * fluro 封装跳转传递值
 */
class Bundle{

  Map<String,dynamic> _map ={};
  //存储键值对数据
  _setValue(var key,var value) => _map[key] =value;

  //根据key获取value
  _getValue(String key){
    if(!_map.containsKey(key)){
      throw Exception("你使用的$key不存在，请仔细检查一下");
    }
    return _map[key];
  }

  putInt(String key,int value) => _map[key] = value;
  putString(String key,String value) =>_setValue(key, value);
  putBool(String key,bool value) => _setValue(key, value);
  putList<V>(String key,List<V> value) => _setValue(key, value);
  putMap<K,V>(String key,Map<K,V> value) => _setValue(key, value);


  int getIntValue(String key) =>_getValue(key) as int;
  String getStringValue(String key) => _getValue(key) as String;
  bool getBoolValue(String key) =>_getValue(key) as bool;
  List getListValue(String key) => _getValue(key) as List;
  Map getMapValue(String key) => _getValue(key) as Map;

  @override
  String toString() {
    return _map.toString();
  }

}