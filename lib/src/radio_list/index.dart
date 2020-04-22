import 'package:beeui/src/form/index.dart';
import 'package:flutter/material.dart';

// import '../form/index.dart';
import '../../bee.dart';
import '../cell.1.dart';
import '../../theme.dart';
import '../util/index.dart';

// onChane
typedef changeBack = void Function(String value);
// icon size
final double _iconSize = 24.0;

class BeeRadiolist extends StatefulWidget {
  // 选项
  final List<BeeRadiolistItem> children;

  // value
  final String value;

  // defaultValue
  final String defaultValue;

  // 排列方式
  final String align;

  // onChange
  final changeBack onChange;

  // icon padding间距
  final double padding = 8.0;

  // left padding
  double _leftPadding;

  // right padding
  double _rightPadding;

  BeeRadiolist({@required this.children,
    this.value,
    this.defaultValue,
    this.align = 'right',
    this.onChange}) {
    if (align == 'left') {
      _leftPadding = 0.0;
      _rightPadding = padding;
    } else {
      _leftPadding = padding;
      _rightPadding = 0.0;
    }
  }

  @override
  _RadiolistState createState() => _RadiolistState();
}

class _RadiolistState extends State<BeeRadiolist> {
  dynamic checked;
  Color primaryColor;

  @override
  void initState() {
    super.initState();
    this.checked = widget.defaultValue;
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    primaryColor = BeeUi
        .getTheme(context)
        .primaryColor;
  }

  dynamic getCheckedValue() {
    return widget.value == null ? checked : widget.value;
  }

  // change
  void change(BeeRadiolistItem item) {
    final value = item.value;
    if (widget.value == null) {
      setState(() {
        checked = value;
      });
    }
    // 调用change
    if (widget.onChange is Function) {
      widget.onChange(value);
    }
  }

  Widget renderIcon(BeeRadiolistItem item) {
    // 是否选中
    final bool isChecked = getCheckedValue() == item.value;
    // 配置了禁用或者达到限制
    final bool isDisabled = isTrue(item.disabled);
    final Color color = Color(0xffc9c9c9);

    return Container(
        width: _iconSize,
        height: _iconSize,
        child: isChecked
            ? Align(
            alignment: Alignment.center,
            child: Icon(BeeIcon.check,
                color: isDisabled ? color : Colors.green, size: 18))
            : null);
  }

  List<BeeCell> renderList() {
    return widget.children.map((item) {
      List<Widget> children;
      // 图标
      final icon = Padding(
          padding: EdgeInsets.only(
              left: widget._leftPadding, right: widget._rightPadding),
          child: renderIcon(item));
      // 内容
      final content = Expanded(
          flex: 1,
          child: Container(
              child: Opacity(
                  opacity: isTrue(item.disabled) ? 0.65 : 1.0,
                  child: toTextWidget(item.label, 'label'))));

      // 排列方式
      if (widget.align == 'left') {
        children = [icon, content];
      } else {
        children = [content, icon];
      }

      return BeeCell(
          content: Row(children: children),
          onTap: item.disabled
              ? null
              : () {
            change(item);
          });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final formContext = BeeForm.of(context);

    return BeeCells(boxBorder: formContext == null, children: renderList());
  }
}

class BeeRadiolistItem {
  final dynamic label;
  final String value;
  final bool disabled;

  BeeRadiolistItem(
      {@required this.label, @required this.value, this.disabled = false});
}
