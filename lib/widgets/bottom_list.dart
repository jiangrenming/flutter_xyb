import 'package:flutter/material.dart';

/**
 * 底部弹出列表
 */

typedef OnItemClick = void Function(int index);

class BottomList extends StatefulWidget {
  OnItemClick itemClick;
  final list;

  BottomList({Key key, this.itemClick, this.list})
      : assert(list != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BottomListState();
  }
}

class _BottomListState extends State<BottomList> {
  var itemCount;
  double itemHeight = 44;
  var borderColor = Colors.white;
  double circular = 10;

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              if (widget.itemClick != null) {
                widget.itemClick(index);
              }
            },
            child:Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                    height: itemHeight,
                    margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // 底色
                    ),
                    child: Center(
                      child: Text(
                        widget.list[index],
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                            color: Color(0xFF333333),
                            fontSize: 18),
                      ),
                    )),
              ],
            )
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1.0,
            color: Colors.grey[100],
          );
        },
        itemCount: widget.list.length);
  }
}
