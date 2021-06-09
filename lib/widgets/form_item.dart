import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:topteam/common/widgets.dart';

class FormItem extends StatelessWidget {
  final String label;
  final bool suffix;
  final bool disabled;
  final bool select;
  final String hintText;
  final TextEditingController controller;
  final value;
  final Function onChanged;
  final FocusNode focusNode;
  final bool showCounter;
  final int maxLength;
  final TextInputType keyboardType;
  final int maxLines;
  final bool readOnly;
  final Function onTap;
  final activeSwitchValue;
  final inactiveSwitchValue;
  final bool stage;
  final bool digitsOnly;
  final Function onEditingComplete;
  final int min;
  final int max;
  
  GlobalKey itemKey = GlobalKey();
  bool bindEvent = false;
  FormItem({
    Key key,
    this.label,
    this.suffix = false,
    this.disabled = false,
    this.select = false,
    this.hintText,
    this.controller,
    this.value,
    this.focusNode,
    this.showCounter = false,
    this.maxLength,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.activeSwitchValue = true,
    this.inactiveSwitchValue = false,
    this.stage = true, this.digitsOnly = false, this.onEditingComplete, this.min, this.max,
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Offstage(
          offstage: this.label == null,
          child: AppText(this.label??' ', fontSize: 15, color: Color(this.disabled ? 0xff999999 : 0xff333333), ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: this.label != null ? 15 : 0),
            constraints: BoxConstraints(minHeight: 60),
            alignment: this.select ? Alignment.centerRight : Alignment.centerLeft,
            child: this.select ? CupertinoSwitch(
              value: this.value == this.activeSwitchValue,
              onChanged: this.readOnly || this.disabled ? null : (value) {
                this.onChanged(value ? this.activeSwitchValue : this.inactiveSwitchValue);
              },
              trackColor: Color(0xffdcdfe6),
              activeColor: Color(0xff3c8cfa),
            ) : TextFormField(
              key: itemKey,
              initialValue: this.value != null ? this.value.toString() : null,
              controller: this.controller,
              focusNode: this.focusNode,
              cursorColor: Color(0xff333333),
              cursorWidth: 1,
              style: TextStyle(fontSize: 15, color: Color(0xff666666)),
              maxLength: this.maxLength,
              keyboardType: this.keyboardType,
              maxLines: this.maxLines,
              readOnly: this.readOnly,
              onTap: this.onTap,
              inputFormatters: this.digitsOnly ? [
                FilteringTextInputFormatter.digitsOnly,
                _MaxFormatter(this.max)
              ] : [],
              onChanged: (value) {
                if (this.digitsOnly) {
                  var num = int.parse(value);
                  if (this.min != null && num < this.min) {
                    num = this.min;
                  }
                  this.onChanged(num);
                } else {
                  this.onChanged(value);
                }
              },
              onEditingComplete: () {
                if (this.digitsOnly) {
                  var num = int.parse(this.controller.text);
                  if (this.min != null && num < this.min) {
                    if (this.controller != null) this.controller.text = min.toString();
                  }
                  if (this.max != null && num > this.max) {
                    if (this.controller != null) this.controller.text = max.toString();
                  }
                }
                this.onEditingComplete();
              },
              decoration: InputDecoration(
                hintText: this.hintText,
                hintStyle: TextStyle(color: Color(0xffcccccc)),
                border: InputBorder.none,
                counterText: this.showCounter ? null : ''
              ),
            )
          )
        ),
        Offstage(
          offstage: !this.suffix,
          child: Icon(Icons.keyboard_arrow_right, color: Color(0xffcccccc),)
        ),
      ],
    );
  }
}

class _MaxFormatter extends TextInputFormatter {
  int max;
  _MaxFormatter(this.max);
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text == '00') {
      return TextEditingValue(
          text: '0',
          selection: TextSelection.fromPosition(TextPosition(offset: 1))
        );
    }
    if (this.max == null || newValue.text == '') {
      return newValue;
    } else {
      var num = int.parse(newValue.text);
      if (num > max) {
        return TextEditingValue(
          text: max.toString(),
          selection: TextSelection.fromPosition(TextPosition(offset: max.toString().length))
        );
      } else {
        return newValue;
      }
    }
  }
}