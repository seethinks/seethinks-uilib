import 'package:beeui/bee.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class InputNumber extends StatefulWidget {
  //最小值
  final double min;

  final String placeholder;

  //最大值
  final double max;

  // 步长
  final dynamic step;

  // onFocus
  final Function onFocus;

  final TextEditingController controller;

  final Function onChange;

  final String defaultValue;

  InputNumber({@required this.controller,
    this.min = 0,
    this.max = 100,
    this.placeholder,
    this.defaultValue,
    this.onFocus,
    this.onChange,
    this.step = 1});

  @override
  _InlineInputState createState() => _InlineInputState();
}

class _InlineInputState extends State<InputNumber> {
  bool isFocus = false;

  bool subDisable = false;
  bool addDisable = false;

  @override
  Widget build(BuildContext context) {
    final defaultColor = BeeUi
        .getTheme(context)
        .defaultBorderColor;
    final lightColor = BeeUi
        .getTheme(context)
        .lightBorderColor;
    final borderColor = !isFocus ? defaultColor : lightColor;
    final double borderWidth = 1;

    return Container(
      height: 34,
      decoration: BoxDecoration(
          border: Border.all(width: borderWidth, color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: !subDisable
                ? () {
              sub();
            }
                : null,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(width: borderWidth, color: defaultColor)),
              ),
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Icon(
                Icons.remove,
                size: 20,
                color: !subDisable ? lightColor : null,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                onFocus();
              },
              child: BeeInput(
                clearable: false,
                rightSpacing: 0,
                decimal: 8,
                type: BeeInputType.NUM_DOUBLE,
                controller: widget.controller,
                textAlign: TextAlign.center,
                placeholder: widget.placeholder,
                height: double.infinity,
                hintStyle: TextStyle(fontSize: 12),
                onFocus: () {
                  onFocus();
                },
                onBlur: () {
                  onBlur();
                },
                onChange: (v) {
                  onChange(v);
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: !addDisable
                ? () {
              add();
            }
                : null,
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(width: borderWidth, color: defaultColor)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Icon(
                Icons.add,
                color: !addDisable ? lightColor : null,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    subDisable = widget.defaultValue == null;
    addDisable = widget.defaultValue == null;

    super.initState();
  }

  setFocus() {
    if (!isFocus) {
      setState(() {
        isFocus = true;
      });
//      widget.controller
    }
  }

  onChange(String v) {
    setTriggerBtnState(v);
    if (widget.onChange is Function) {
      widget.onChange(v);
    }
  }

  setText(String newVal) {
    widget.controller.text = newVal.toString();
    widget.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.controller.text.length));
    setFocus();
  }

  setTriggerBtnState(String newVal) {
    setState(() {
      subDisable = widget.min == null ||
          newVal.isEmpty ||
          NumUtil.subtract(double.parse(newVal), widget.step) < widget.min;


      addDisable = widget.max == null ||
          newVal.isEmpty ||
          NumUtil.add(double.parse(newVal), widget.step) > widget.max;
    });
  }

  // 递增步长
  add() {
    final oldVal = widget.controller.text;

    var newVal = NumUtil.add(double.parse(oldVal), widget.step);

    setText(newVal.toString());
  }

  // 递减步长
  sub() {
    final oldVal = widget.controller.text;
    var newVal = NumUtil.subtract(double.parse(oldVal), widget.step);

    setText(newVal.toString());
  }

  onFocus() {
    setState(() {
      isFocus = true;
    });
    if (widget.onFocus is Function) {
      widget.onFocus();
    }
  }

  onBlur() {
    setState(() {
      isFocus = false;
    });
  }
}
