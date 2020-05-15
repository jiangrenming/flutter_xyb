import 'package:flutter/material.dart';

//空数据时的界面
class NoDataView extends StatefulWidget{

  final VoidCallback emptyRetry; //无数据事件处理

  NoDataView(this.emptyRetry);

  @override
  State<StatefulWidget> createState() {
    return _NoDataViewState();
  }

}

class _NoDataViewState extends State<NoDataView>{
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: 750,
        height: double.infinity,
        child: InkWell(
          onTap: widget.emptyRetry,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 405,
                height: 281,
                child: Image.asset('images/no_data.png'),
              ),
              Text('暂无相关数据,轻触重试~',style: TextStyle(color:Colors.grey[100],fontSize: 16.0),)
            ],
          ),
        )
    );
  }
}