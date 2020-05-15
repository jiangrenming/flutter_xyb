import 'package:flutter/material.dart';

/**
 * 底部弹出窗 <实现例如相册，相机，取消等按钮>
 */
typedef OnItemClickListener = void Function(int index);

class CommonBottomSheet extends StatefulWidget {
  final list;
  final OnItemClickListener onItemClickListener;

  CommonBottomSheet({Key key, this.list, this.onItemClickListener})
      : assert(list != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CommonBottomSheetState();
  }
}

class _CommonBottomSheetState extends State<CommonBottomSheet> {
  var itemCount;
  double itemHeight = 44;
  var borderColor = Colors.white;
  double circular = 10;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    Orientation orientation = MediaQuery
        .of(context)
        .orientation;
    var deviceWidth = orientation == Orientation.portrait
        ? screenSize.width
        : screenSize.height;

    /// *2-1是为了加分割线，最后还有一个cancel，所以加1
    itemCount = (widget.list.length * 2 - 1) + 1;
    var height = ((widget.list.length + 1) * 48).toDouble();

    var stack = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
            bottom: 0,
            child: Container(
              height: height,
              width: deviceWidth * 0.98,
              child: ListView.builder(
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    if (itemCount - 1 == index) {
                      return Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Container(
                          //取消按钮
                            height: itemHeight,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white, // 底色
                              borderRadius: BorderRadius.circular(circular),
                            ),
                            child: Center(
                              child: GestureDetector(
                                child: Text("取消", style: TextStyle(
                                    fontFamily: 'Robot',
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                    color: Color(0xff333333),
                                    fontSize: 18
                                ),),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            )
                        ),
                      );
                    }
                    return getItemContainer(context, index);
                  }),
            ))
      ],
    );
    return stack;
  }

  Widget getItemContainer(BuildContext context, int index) {
    if (widget.list == null) {
      return Container();
    }
    if (index.isOdd) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Divider(
          height: 0.5,
          color: borderColor,
        ),
      );
    }
    var borderRadius;
    var margin;
    var border;
    var borderAll = Border.all(color: borderColor, width: 0.5);
    var borderSide = BorderSide(color: borderColor, width: 0.5);
    var isFirst = false;
    var isLast = false;

    if (widget.list.length == 1) {
      borderRadius = BorderRadius.circular(circular);
      margin = EdgeInsets.only(bottom: 10, left: 10, right: 10);
      border = borderAll;
    } else if (widget.list.length > 1) {
      /// 第一个元素
      if (index == 0) {
        isFirst = true;
        borderRadius = BorderRadius.only(topLeft: Radius.circular(circular),
            topRight: Radius.circular(circular));
        margin = EdgeInsets.only(left: 10, right: 10,);
        border = Border(top: borderSide, left: borderSide, right: borderSide);
      } else if (index == itemCount - 2) {
        isLast = true;

        /// 最后一个元素
        borderRadius = BorderRadius.only(bottomLeft: Radius.circular(circular),
            bottomRight: Radius.circular(circular));
        margin = EdgeInsets.only(left: 10, right: 10);
        border =
            Border(bottom: borderSide, left: borderSide, right: borderSide);
      } else {
        /// 其他位置元素
        margin = EdgeInsets.only(left: 10, right: 10);
        border = Border(left: borderSide, right: borderSide);
      }
    }

    var isFirstOrLast = isFirst || isLast;
    int listIndex = index ~/ 2;
    var text = widget.list[listIndex];
    var contentText = Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
          color: Color(0xFF333333),
          fontSize: 18),
    );
    var center;
    if (!isFirstOrLast) {
      center = Center(
        child: contentText,
      );
    }

    var itemContainer = Container(
        height: itemHeight,
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.white, // 底色
          borderRadius: borderRadius,
          border: border,
        ),
        child: center);

    var onTap2 = () {
      if (widget.onItemClickListener != null) {
        widget.onItemClickListener(index);
      }
    };
    var stack = Stack(
      alignment: Alignment.center,
      children: <Widget>[itemContainer, contentText],
    );
    var getsture = GestureDetector(
      onTap: onTap2,
      child: isFirstOrLast ? stack : itemContainer,
    );
    return getsture;
  }

}
