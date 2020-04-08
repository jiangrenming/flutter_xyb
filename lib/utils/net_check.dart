import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';


//判断网络是否正确和可用
class NetWorkCheck{


 static Future<int> isNetWorkAvailable() async{
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile)
      return 1;
    else if (connectivityResult == ConnectivityResult.wifi)
      return 2;
    else if (connectivityResult == ConnectivityResult.none)
      return 0;
  }
}