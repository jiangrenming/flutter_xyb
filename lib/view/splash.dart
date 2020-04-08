import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_xyb/utils/share_utils.dart';
import 'package:flutter_xyb/constants/contants.dart';
import 'package:flutter_xyb/view/login/login.dart';

class SplashPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }

}

class _SplashPageState extends State<SplashPage>{

  List<PermissionGroup> permissis ;
  String token;

  @override
  Widget build(BuildContext context) {
    return _getWidgets();
  }


  Widget _getWidgets(){
     asyRequestPermission();
      SharedPreferencesDataUtils.getInstance().getString(Constans.TOKEN).then((String t) =>{
       token = t
     });
     print("-----1"+token.toString());
    if(token != null){
        return Scaffold(

        );
    }else{
      return Scaffold(
        body: LoginPages(),
      );
    }
  }


/* void _onData(String event){
    setState(() {
      token = event;
    });
 }*/


  Future<bool> asyRequestPermission() async {
    permissis = new List();
    permissis.clear();
    Map<PermissionGroup,PermissionStatus> permissions = await PermissionHandler()
        .requestPermissions([PermissionGroup.camera,PermissionGroup.location,PermissionGroup.photos,
      PermissionGroup.phone,PermissionGroup.storage,]);

    if(permissions[PermissionGroup.camera] != PermissionStatus.granted){
      print("-----1");
       permissis.add(PermissionGroup.camera);
    }
    if(permissions[PermissionGroup.location] != PermissionStatus.granted){
      print("-----2");
      permissis.add(PermissionGroup.location);
    }
    if(permissions[PermissionGroup.phone] != PermissionStatus.granted){
      print("-----3");
      permissis.add(PermissionGroup.phone);
    }
    if(permissions[PermissionGroup.storage] != PermissionStatus.granted){
      print("-----4");
      permissis.add(PermissionGroup.storage);
    }
    if( permissis.isNotEmpty){
      print("-----5");
      bool isOpened = await PermissionHandler().openAppSettings();
      return false;
    }
    return true;
  }
}