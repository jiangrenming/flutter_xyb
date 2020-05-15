import 'package:flutter/material.dart';
import 'package:flutter_xyb/widgets/loading_dialog.dart';
import 'package:flutter_xyb/page_manager/no_data.dart';

//四种视图状态
enum LoadState { State_Success, State_Error, State_Loading, State_Empty }

//根据不同状态来加载不同的界面
class LoadStateLayout extends StatefulWidget {

  final LoadState state; //视图状态
  final Widget successWidget; //成功视图
  final VoidCallback errorRetry; //错误事件处理
  final VoidCallback emptyRetry; //空数据事件处理

  bool outSideMiss = true;
  String content;

  LoadStateLayout({
    this.state = LoadState.State_Loading, //默认加载视图
    this.successWidget,
    this.errorRetry,
    this.emptyRetry,
    this.outSideMiss,
    this.content
  }):assert(content != null);

  @override
  State<StatefulWidget> createState() {
    return _LoadStateLayoutState();
  }
}

class _LoadStateLayoutState extends State<LoadStateLayout>{

  @override
  Widget build(BuildContext context) {
     return Container(
       width:double.infinity ,
       height: double.infinity,
       child: _childWidget(),
     );
  }

  //根据不同状态返回不同的界面
 Widget  _childWidget() {
   switch(widget.state){
     case LoadState.State_Loading:
       return LoadingView();
       break;
     case LoadState.State_Success:
       return widget.successWidget;
       break;
     case LoadState.State_Empty:
       return NoDataView(widget.emptyRetry);
       break;
     case LoadState.State_Error:
       return LoadingErrorView();
       break;
     default:
       return null;
   }
 }

 //加载中...这里的加载形式可以自己再自定义
  Widget LoadingView() {
    return LoadingDialog(outSideMiss: widget.outSideMiss,content: widget.content);
  }

  //加载失败..
  Widget LoadingErrorView() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: InkWell(
          onTap: widget.errorRetry,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 405,
                height: 317,
                child: Image.asset('images/icon_work.png'),
              ),
              Text("加载失败，请轻触重试!",style: TextStyle(color: Colors.grey[100],fontSize: 16),),
            ],
          ),
        )
    );
  }

}
