import 'package:flutter/material.dart';
import 'package:flutter_xyb/utils/share_utils.dart';
import 'package:flutter_xyb/constants/contants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_xyb/utils/md5_util.dart';
import 'package:flutter_xyb/http/dio_net.dart';
import 'package:flutter_xyb/module/login_entity.dart';
import 'package:flutter_xyb/base/response_entity.dart';

//import 'package:rflutter_alert/rflutter_alert.dart' as RflutterAlert;
//登陆页
class LoginPages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPagesState();
  }
}

class _LoginPagesState extends State<LoginPages> {
  final GlobalKey<FormFieldState<String>> _PasswordFieldKey =
      GlobalKey<FormFieldState<String>>();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();

  //判断有误错误提示
  String _errorPasswordText = "";
  String _errorUserNameText = "";

  //密码值
  String _password = "";

  //checkbox是否选中
  bool _checkValue = false;

  //显示隐藏密码状态
  bool _obscureText = true;

  //显示隐藏清除图标
  bool _hasdeleteIcon = false;

  @override
  void initState() {
    super.initState();
    _userNameController.addListener(() {
      var phone = _userNameController.text;
    });

    _passwordController.addListener(() {
      var password = _passwordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Constans.ASSETS_IMG + "login_bg.png"),
              fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              Constans.ASSETS_IMG + "icon_login_logo.png",
              width: 120.0,
              height: 120.0,
            ),
            Text(
              "欢迎登陆乡医保",
              style: TextStyle(fontSize: 22.0, color: Colors.blue),
            ),
            SizedBox(height: 60.0),
            //手机号
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45.0,
              color: Colors.transparent,
              child: TextFormField(
                controller: _userNameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: "请输入手机号码",
                  fillColor: Colors.transparent,
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0),
                  errorText:
                      _errorUserNameText.isEmpty ? "" : _errorUserNameText,
                  border: OutlineInputBorder(),
                  suffixIcon: _hasdeleteIcon
                      ? Container(
                          width: 20.0,
                          height: 20.0,
                          child: IconButton(
                              icon: Icon(Icons.cancel),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(0.0),
                              iconSize: 20.0,
                              onPressed: () {
                                setState(() {
                                  _userNameController.text = "";
                                  _hasdeleteIcon =
                                      (_userNameController.text.isNotEmpty);
                                });
                              }),
                        )
                      : Text(""),
                ),
              ),
            ),

            SizedBox(height: 10.0),
            //密码
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45.0,
              color: Colors.transparent,
              child: TextFormField(
                controller: _passwordController,
                textInputAction: TextInputAction.done,
                obscureText: _obscureText,
                onFieldSubmitted: (String value) {
                  //内容发生改变时 回调
                  setState(() {
                    this._password = value;
                  });
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: "请输入6-18字母或数字密码",
                  fillColor: Colors.transparent,
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0),
                  errorText:
                      _errorPasswordText.isEmpty ? "" : _errorPasswordText,
                  border: OutlineInputBorder(),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),
            ),

            //协议
            Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 0, 5),
              child: Row(
                children: <Widget>[
                  Transform.scale(
                    scale: 0.7,
                    child: Checkbox(
                        value: _checkValue,
                        checkColor: Colors.grey,
                        activeColor: Colors.blue,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (bool value) {
                          setState(() {
                            _checkValue = value;
                          });
                        }),
                  ),
                  Row(
                    children: <Widget>[
                      Text("勾选即代表同意", style: TextStyle(fontSize: 11.0)),
                      GestureDetector(
                        onTap: () {
                          //ToDo()跳转页面
                        },
                        child: Text(
                          "<用户协议>",
                          style: TextStyle(fontSize: 11.0, color: Colors.blue),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //ToDo()跳转页面
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(50.0, 0.0, 10.0, 0.0),
                          child: Text(
                            "忘记密码",
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            //登陆按钮
            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: InkWell(
                onTap: () {
                  _checkParams(context, _userNameController,
                      _passwordController, _checkValue);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  color: Colors.blue,
                  alignment: Alignment(0.0, 0.0),
                  child: Center(
                    child: Text(
                      "登陆",
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /**
   * 提交按钮
   */
  LoginEntity _loginEntity;

  void _checkParams(
      BuildContext context,
      TextEditingController userNameController,
      TextEditingController passwordController,
      bool checkValue) {
    String phone = userNameController.text;
    String pwd = passwordController.text;
    _errorUserNameText = _validateName(phone);
    _errorPasswordText = _validatePwd(pwd);
    if (phone.isNotEmpty && pwd.isNotEmpty) {
      if (!checkValue) {
        Fluttertoast.showToast(msg: "请先勾选协议");
      } else {
        //TodO()调起接口
        final Map<String, dynamic> params = new Map();
        params["phone"] = phone;
        params["pwd"] = Md5Utils.generateMd5("123456");
        DioApi.getInstance().post<HttpResponseEntity, LoginEntity>(
            "/userInfo/login",
            params: params, sucessCallback: (response) {
          _loginEntity = response;
          print("返回的数据" + _loginEntity.name);
        }, reLoginCallBack: (special) {
          switch (special['resultCode']) {
            case "401":
              //TodO()重新登陆
              break;
            default:
              Fluttertoast.showToast(
                msg: special['message'],
                fontSize: 14,
                toastLength: Toast.LENGTH_SHORT,
              );
          }
        }, errorCallback: (error) {
          Fluttertoast.showToast(
            msg: error['message'],
            fontSize: 14,
            toastLength: Toast.LENGTH_SHORT,
          );
        });
      }
    }
  }

  String _validateName(String value) {
    if (value.isEmpty) return '手机号不能为空';
    final RegExp nameExp = RegExp(r'^1[3|4|5|7|8|9][0-9]\\d{8}$');
    if (!nameExp.hasMatch(value)) {
      return '手机号码格式不正确';
    }
    return null;
  }

  String _validatePwd(String value) {
    if (value.isEmpty) return '密码不能为空';
    final RegExp nameExp = RegExp(r'^[0-9a-zA-Z]{6,18}$');
    if (!nameExp.hasMatch(value)) {
      return '密码为6-18位的数字或字母组成';
    }
    return null;
  }
}
