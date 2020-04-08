import 'package:flutter/material.dart';

//普通输入框封装

class InputTextWidget extends StatefulWidget {
  final String hintText;
  final String helperText;
  final String errorText;
  final TextInputType keyboardType;
  final String labelText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final TextEditingController controller;



  InputTextWidget(
      {this.hintText,
      this.helperText,
      this.errorText,
      this.keyboardType,
      this.labelText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.controller});

  @override
  State<StatefulWidget> createState() {
    return _InputTextWidgetState();
  }
}

class _InputTextWidgetState extends State<InputTextWidget> {
  bool _delIcon = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 65.0,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        textInputAction: TextInputAction.next,
        controller: widget.controller,
        onSaved: widget.onSaved,
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: widget.validator,
        textCapitalization: TextCapitalization.words,
        maxLengthEnforced: true,
        maxLines: 1,
        decoration: InputDecoration(
            icon: Icon(Icons.phone),
            fillColor: Colors.transparent,
            filled: true,
            border: OutlineInputBorder(),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey,fontSize: 13.0),
            errorText: widget.errorText,
            helperText: widget.helperText,
            labelText: widget.labelText,
            /*suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  widget.controller.clear();
                  _delIcon = false;
                });
              },
              child: Icon(_delIcon ? null : Icons.close),
            )*/),
      )
    );
  }
}
