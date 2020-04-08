import 'package:flutter/material.dart';
//密码输入框
class PwdTextWidget extends StatefulWidget{


  /**
   * 大部分属性同TextFiled
   *
   * TextFormField({
      Key key,
      this.controller,//控制正在编辑的文本。如果为空，这个小部件将创建自己的TextEditingController并使用initialValue初始化它的TextEditingController.text
      String initialValue,//初始值
      FocusNode focusNode,
      InputDecoration decoration = const InputDecoration(),//输入器装饰
      TextInputType keyboardType,//弹出键盘的类型
      TextCapitalization textCapitalization = TextCapitalization.none,//户输入中的字母大写的选项,TextCapitalization.sentences每个句子的首字母大写,TextCapitalization.characters:句子中的所有字符都大写，TextCapitalization.words : 将每个单词的首字母大写。
      TextInputAction textInputAction,//更改TextField的textInputAction可以更改键盘右下角的操作按钮,搜索，完成
      TextStyle style,
      TextDirection textDirection,//文字显示方向
      TextAlign textAlign = TextAlign.start,//文字显示位置
      bool autofocus = false,//自动获取焦点
      bool obscureText = false,//是否隐藏输入，true密码样式显示，false明文显示
      bool autocorrect = true,
      bool autovalidate = false,//是否自动验证值
      bool maxLengthEnforced = true,
      int maxLines = 1,//编辑框最多显示行数
      int maxLength,//输入最大长度，并且默认情况下会将计数器添加到TextField
      VoidCallback onEditingComplete,//当用户提交时调用
      ValueChanged<String> onFieldSubmitted, //内容发送改变时调用
      FormFieldSetter<String> onSaved,//当Form表单调用保存方法save时回调
      FormFieldValidator<String> validator,//Form表单验证
      List<TextInputFormatter> inputFormatters,
      bool enabled = true,
      Brightness keyboardAppearance,
      EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
      bool enableInteractiveSelection = true,
      })
   */

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final String errorText;
  final FormFieldSetter<String> onSaved;  //点击保存回调
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final TextEditingController controller;

  PwdTextWidget(
      {
        Key key,
        this.errorText,
        this.controller,
        this.fieldKey,
        this.hintText,
        this.labelText,
        this.helperText,
        this.onSaved,
        this.validator,
        this.onFieldSubmitted
      }
    ):super(key:key);


  @override
  State<StatefulWidget> createState() {
    return _PwdTextWidgetState();
  }

}

class _PwdTextWidgetState  extends State<PwdTextWidget>{

  //显示隐藏密码状态
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45.0,
      child:  TextFormField(
        controller: widget.controller,
        key: widget.fieldKey,
        obscureText: _obscureText,
        maxLines: 1,
        maxLengthEnforced: true,
        onSaved: widget.onSaved,
        onFieldSubmitted: widget.onFieldSubmitted,
        validator:widget.validator ,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            fillColor:Colors.transparent,
            filled: true,
            border: OutlineInputBorder(),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey,fontSize: 13.0),
            errorText: widget.errorText,
            labelText: widget.labelText,
            helperText: widget.helperText,
            icon: Icon(Icons.lock),
            suffixIcon: GestureDetector(
              onTap: (){
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            )
        ),
      ),
    );
  }
}

/*InputDecoration({
this.icon,    //位于装饰器外部和输入框前面的图片
this.labelText,  //用于描述输入框，例如这个输入框是用来输入用户名还是密码的，当输入框获取焦点时默认会浮动到上方，
this.labelStyle,  // 控制labelText的样式,接收一个TextStyle类型的值
this.helperText, //辅助文本，位于输入框下方，如果errorText不为空的话，则helperText不会显示
this.helperStyle, //helperText的样式
this.hintText,  //提示文本，位于输入框内部
this.hintStyle, //hintText的样式
this.hintMaxLines, //提示信息最大行数
this.errorText,  //错误信息提示
this.errorStyle, //errorText的样式
this.errorMaxLines,   //errorText最大行数
this.hasFloatingPlaceholder = true,  //labelText是否浮动，默认为true，修改为false则labelText在输入框获取焦点时不会浮动且不显示
this.isDense,   //改变输入框是否为密集型，默认为false，修改为true时，图标及间距会变小
this.contentPadding, //内间距
this.prefixIcon,  //位于输入框内部起始位置的图标。
this.prefix,   //预先填充的Widget,跟prefixText同时只能出现一个
this.prefixText,  //预填充的文本，例如手机号前面预先加上区号等
this.prefixStyle,  //prefixText的样式
this.suffixIcon, //位于输入框后面的图片,例如一般输入框后面会有个眼睛，控制输入内容是否明文
this.suffix,  //位于输入框尾部的控件，同样的不能和suffixText同时使用
this.suffixText,//位于尾部的填充文字
this.suffixStyle,  //suffixText的样式
this.counter,//位于输入框右下方的小控件，不能和counterText同时使用
this.counterText,//位于右下方显示的文本，常用于显示输入的字符数量
this.counterStyle, //counterText的样式
this.filled,  //如果为true，则输入使用fillColor指定的颜色填充
this.fillColor,  //相当于输入框的背景颜色
this.errorBorder,   //errorText不为空，输入框没有焦点时要显示的边框
this.focusedBorder,  //输入框有焦点时的边框,如果errorText不为空的话，该属性无效
this.focusedErrorBorder,  //errorText不为空时，输入框有焦点时的边框
this.disabledBorder,  //输入框禁用时显示的边框，如果errorText不为空的话，该属性无效
this.enabledBorder,  //输入框可用时显示的边框，如果errorText不为空的话，该属性无效
this.border, //正常情况下的border
this.enabled = true,  //输入框是否可用
this.semanticCounterText,
this.alignLabelWithHint,
})*/

