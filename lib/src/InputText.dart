import 'package:beeui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../bee.dart';
import './cell.1.dart';
import './util/index.dart';
import 'icon.dart';

enum BeeInputType {
  PHONE, //手机号
  TEXT, //文本
  PASSWORD, // 密码
  NUM_INT, // 整型数字
  NUM_DOUBLE, // 浮点数字
  BANK
}


Map<BeeInputType, WhitelistingTextInputFormatter> _formatters = {
  BeeInputType.NUM_INT: WhitelistingTextInputFormatter.digitsOnly,
  BeeInputType.NUM_DOUBLE: WhitelistingTextInputFormatter(RegExp("[0-9.]")),
};

class BeeInput extends StatefulWidget {
  // key
  final Key key;

  // label
  final dynamic label;

  // 高度
  final double height;

  // 默认值
  final String defaultValue;

  // 最大行数
  final int maxLines;

  // 限制输入数量
  final int maxLength;

  // 提示文字
  final String placeholder;

  // 光标
  final FocusNode focusNode;

  // footer
  final Widget footer;

  // 是否显示清除
  final bool clearable;

  // 文字对其方式
  final TextAlign textAlign;

  // 输入框类型
  final BeeInputType type;

  // 密码框
  final bool obscureText;

  // 样式
  final TextStyle style;

  // 是否自动获取光标
  final bool autofocus;

  // label宽度
  final double labelWidth;

  // TextInputAction
  final TextInputAction textInputAction;

  // onChange
  final Function(String value) onChange;

  // onFocus
  final Function onFocus;

  // onBlur
  final Function onBlur;

  //
  final TextStyle hintStyle;

  // 是否显示边框
  final bool isBorder;

  // 控制器
  final TextEditingController controller;

  final double rightSpacing;

  //是否禁用
  final disable;

  // 小数位
  final int decimal;

  BeeInput({
    this.key,
    label,
    this.height = 48,
    this.defaultValue = '',
    this.maxLines = 1,
    this.maxLength,
    this.placeholder,
    this.focusNode,
    this.footer,
    this.clearable = true,
    this.textAlign = TextAlign.start,
    this.type = BeeInputType.TEXT,
    this.obscureText = false,
    this.style,
    this.disable = false,

    this.autofocus = false,
    this.isBorder = false,
    this.rightSpacing = 15,
    this.labelWidth = 80.0,
    this.decimal = 2,
    @required this.controller,
    this.textInputAction,
    this.onChange,
    this.onFocus,
    this.onBlur,
    this.hintStyle = TextStyle(fontSize: 14),
  })
      : this.label = toTextWidget(label, 'label'),
        super(key: key);

  @override
  BeeInputState createState() => BeeInputState();
}

class BeeInputState extends State<BeeInput> {
  TextInputAction textInputAction;

  FocusNode _focus = new FocusNode();

  bool isTextFocus = false;

  bool obscureText = false;

  BeeInputState() {
    _init();
  }

  @override
  void initState() {
    if (widget.textInputAction == null) {
      textInputAction = widget.maxLines == 1
          ? TextInputAction.search
          : TextInputAction.newline;
    } else {
      textInputAction = widget.textInputAction;
    }

    textInputAction = widget.textInputAction;

    obscureText = widget.type == BeeInputType.PASSWORD ? true : false;

    widget.controller.addListener(onChange);
    _focus.addListener(_onFocusChange);
    super.initState();
  }

  // 初始化
  _init() {
    WidgetsBinding.instance.addPostFrameCallback((Duration time) {
      _setValue(widget.defaultValue);
    });
  }

  onChange() {
    var value = widget.controller.text;
    if (widget.type == BeeInputType.NUM_DOUBLE) {
      int index = value.indexOf(".");

      //小数点后位数
      if (index > -1) {
        int lengthAfterPointer = value
            .substring(index, value.length)
            .length - 1;

        ///小数位大于精度
        if (lengthAfterPointer > widget.decimal) {
          value = value.substring(0,
              index + widget.decimal + 1);
        }
      }
    }

    if (widget.onChange is Function) {
      widget.onChange(widget.controller.text);
    }

//    setState(() {
//      widget.controller.text = value;
//    });
//    setSelection();
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      if (widget.onFocus is Function) {
        widget.onFocus();
      }
      setState(() {
        isTextFocus = true;
      });
    } else {
      if (widget.onBlur is Function) {
        widget.onBlur();
      }
      setState(() {
        isTextFocus = false;
      });
    }
  }

  // 清除value
  void _clearValue() {
    _setValue('');
    if (widget.onChange is Function) {
      widget.onChange('');
    }
  }

  /// 每隔 x位 加 pattern
  String formatDigitPattern(String text,
      {int digit = 4, String pattern = ' '}) {
    text = text?.replaceAllMapped(new RegExp("(.{$digit})"), (Match match) {
      return "${match.group(0)}$pattern";
    });
    if (text != null && text.endsWith(pattern)) {
      text = text.substring(0, text.length - 1);
    }
    return text;
  }

  // 输入框onChange
  void _onChange(String value) {
    if (widget.type == BeeInputType.BANK) {
      value = formatDigitPattern(value);
    }
    if (widget.onChange is Function) {
      widget.onChange(value);
    }
    setState(() {

    });
//    setSelection();
  }

  setSelection() {
    widget.controller.selection = TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: widget.controller.text.length));
  }

  void _setValue(value) {
    setState(() {
      widget.controller.text = value;
      obscureText = obscureText;
    });
    setSelection();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color lightBorderColor = BeeUi
        .getTheme(context)
        .primaryColor;
    final Color defaultBorderColor = BeeUi
        .getTheme(context)
        .defaultBorderColor;

    final Color hintColor = BeeUi
        .getTheme(context)
        .hintColor;
    // 清除按钮
    final Widget clearWidget = GestureDetector(
        onTap: _clearValue,
        child: Container(child: Icon(Icons.cancel, size: 16.0)));

    // label
    Widget label;
    if (widget.label is Widget) {
      label = Container(width: widget.labelWidth, child: widget.label);
    }

    // footer
    Widget footer;
    List<Widget> arr = [];
    if (!widget.disable && widget.clearable &&
        widget.controller.text.length > 0) {
      arr.add(Padding(
          padding: EdgeInsets.only(right: widget.footer is Widget ? 5 : 0),
          child: clearWidget));
//      footer = widget.controller.text.length > 0 ? clearWidget : null;
    } else {
//      footer = widget.footer;
    }


    if (widget.type == BeeInputType.PASSWORD) {
      arr.add(Padding(
          padding: EdgeInsets.only(left: widget.clearable ? 5 : 0, right: 5),
          child: Eye(defaultOpen: obscureText, size: 16, onChange: (v) {
            setState(() {
              obscureText = v;
            });
          },)));
    }

    if (widget.footer is Widget) {
      arr.add(widget.footer);
    }

    footer = Container(
        child: Row(
            children: arr)
    );

    TextInputType textInputType = setKeyboardType();

    List<TextInputFormatter> formatterArr = setFormatters();

    return Container(
        decoration: widget.isBorder
            ? BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color:
                    isTextFocus ? lightBorderColor : defaultBorderColor,
                    width: 1)))
            : null,
        child: BeeCell(
            label: label,
            spacing: 0,
            rightSpacing: widget.rightSpacing,
            footer: footer,
            minHeight: widget.height,
            content: TextField(
                cursorWidth: 2,
                autofocus: widget.autofocus,
                textAlign: widget.textAlign,
                keyboardType: textInputType,
                textInputAction: textInputAction,
                obscureText: obscureText,
                style: widget.style,
                controller: widget.controller,
                focusNode: _focus,
                readOnly: widget.disable,
                onChanged: _onChange,
                maxLines: widget.maxLines,
                maxLength: widget.maxLength,
                inputFormatters: formatterArr,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    border: InputBorder.none,
                    hintStyle: widget.hintStyle.copyWith(
                        fontSize: 14, color: hintColor),
                    hintText: widget.placeholder,
                    counterText: ''))));
  }

  setKeyboardType() {
    if (widget.type == BeeInputType.NUM_DOUBLE ||
        widget.type == BeeInputType.NUM_INT) {
      return TextInputType.number;
    }

    if (widget.type == BeeInputType.PHONE) {
      return TextInputType.number;
    }
    return TextInputType.text;
  }

  setFormatters() {
    List<TextInputFormatter> arr = [];
    if (widget.type == BeeInputType.NUM_DOUBLE) {
      arr.add(WhitelistingTextInputFormatter(RegExp("[0-9.]")));
      arr.add(UsNumberTextInputFormatter(widget.decimal));
    }

    if (widget.type == BeeInputType.NUM_INT ||
        widget.type == BeeInputType.PHONE) {
      arr.add(WhitelistingTextInputFormatter.digitsOnly);
    }
    return arr;
  }
}


// 只允许输入合法的小数
class UsNumberTextInputFormatter extends TextInputFormatter {
  int decimal;

  UsNumberTextInputFormatter(this.decimal);

  static const defaultDouble = 0.001;

  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (value == ".") {
      value = "0.";
      selectionIndex++;
    }

    if (value != "" &&
        value != defaultDouble.toString() &&
        strToFloat(value, defaultDouble) == defaultDouble) {
      value = oldValue.text;

      selectionIndex = oldValue.selection.end;
    }

    print("value==${value}");

    int index = value.indexOf(".");

    //小数点后位数
    if (index > -1) {
      int lengthAfterPointer = value
          .substring(index, value.length)
          .length - 1;

      ///小数位大于精度
      if (lengthAfterPointer > decimal) {
//        // 粘贴的时候
//        if (oldValue == null) {
//          return new TextEditingValue(
//            text: value,
//            selection: new TextSelection.collapsed(offset: selectionIndex),
//          );;
//        }
        return oldValue;
      }
    }

    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
