import 'package:flutter/material.dart';
import 'package:flutter_xyb/widgets/loading_widget.dart';

/**
 * 加载框
 */
class LoadingDialog extends Dialog {
  bool outSideMiss = true;
  String content;

  LoadingDialog({this.outSideMiss, this.content}) : assert(content != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (outSideMiss) {
                  Navigator.pop(context);
                }
              },
            ),
            _dialog(),
          ],
        ),
      ),
    );
  }

  Widget _dialog() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            )),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      content,
                      style: TextStyle(fontSize: 16.0, color: Colors.blue),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
