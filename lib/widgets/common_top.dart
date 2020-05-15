import 'package:flutter/material.dart';

/**
 * 共同顶部操作
 */

typedef   onBackCallBack = void Function();
typedef   onRightCallBack = void Function();

class CommonTopWidget extends StatefulWidget {
  bool mIsBackIcon = true;
  bool mRightIcon = false;
  IconData mIcon;
  String title = "";

  onBackCallBack onBack;
  onRightCallBack onRight;

  CommonTopWidget(String title,
      {this.mIsBackIcon, this.mRightIcon, this.mIcon,this.onBack,this.onRight})  : assert(title != null);


  @override
  State<StatefulWidget> createState() {
    return _CommonTopWidgetState();
  }
}

class _CommonTopWidgetState extends State<CommonTopWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        children: <Widget>[
          Container(
              child: Offstage(
            offstage: !widget.mIsBackIcon,
            child: GestureDetector(
              child:Icon(
                Icons.arrow_back,
                color: Colors.white,
              ) ,
              onTap: (){
                if(widget.onBack != null){
                  widget.onBack();
                }
              },
            ),
          )),
          Expanded(
            flex: 4,
            child: Center(
                child: Text(widget.title,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        decoration: TextDecoration.none))),
          ),
          Container(
            child: Offstage(
              offstage: !widget.mRightIcon,
             child: GestureDetector(
               child: Icon(widget.mIcon, color: Colors.white),
               onTap: (){
                 if(widget.onRight != null){
                   widget.onRight();
                 }
               },
             ),
            ),
          )
        ],
      ),
    );
  }
}
