import 'package:flutter/material.dart';

import '../theme.dart';

// 间距
const double labelSpacing = 20.0;
const double _lineSpacing = 0;

class BeeCells extends StatelessWidget {
  final bool boxBorder;
  final bool splitBorder;
  final double spacing;
  final double lineSpacing;
  final List<Widget> children;

  BeeCells({
    this.boxBorder = true,
    this.splitBorder = true,
    this.spacing = labelSpacing,
    this.lineSpacing = _lineSpacing,
    @required this.children,
  });

  @override
  Widget build(BuildContext context) {
    // 边框
    final Color borderColor = BeeUi
        .getTheme(context)
        .defaultBorderColor;
    final cellBackgroundColor = BeeUi
        .getTheme(context)
        .cellBackgroundColor;
    final Divider _border = Divider(height: 1, color: borderColor);
    final List<Widget> newChildren = [];

    children.forEach((item) {
      if (item != children[0] && splitBorder) {
        newChildren.add(
            Padding(padding: EdgeInsets.only(left: spacing), child: _border));
      }
      newChildren.add(Padding(
          padding: EdgeInsets.only(bottom: lineSpacing),
          child: item
      ));
    });

    // 判断是否添加容器边框
    if (boxBorder) {
      newChildren.add(_border);
      newChildren.insert(0, _border);
    }

    return Container(
        decoration: BoxDecoration(color: cellBackgroundColor),
        child: _BeeCellsScope(
          beeCells: this,
          child: Column(children: newChildren),
        ));
  }
}

class BeeCell extends StatelessWidget {
  // label
  final Widget label;

  final Widget labelIcon;

  // 内容
  final Widget content;

  // footer
  final Widget footer;

  // 对齐方式
  final Alignment align;

  // 间距
  final double spacing;


  // 右侧间距，默认15
  final double rightSpacing;

  // 最小高度
  final double minHeight;

  // 点击
  final Function onTap;

  BeeCell({label,
    content,
    this.footer,
    this.labelIcon,
    this.align = Alignment.centerRight,
    this.spacing = labelSpacing,
    this.rightSpacing = 15.0,
    this.minHeight = 46.0,
    this.onTap})
      : this.label = label is String ? Text(label) : label,
        this.content = content is String ? Text(content) : content;

  // 点击
  void _onTap() {
    onTap();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    final _BeeCellsScope BeeCellsScope = _BeeCellsScope.of(context);
    final double _spacing =
    BeeCellsScope == null ? spacing : BeeCellsScope.beeCells.spacing;
    final cellTitleStyle = BeeUi
        .getTheme(context)
        .cellTitleStyle;

    if (labelIcon is Widget) {
      children = [
        Padding(
          padding: EdgeInsets.only(right: 5),
          child: labelIcon,
        )
      ];
    }

    // label
    if (label is Widget) {
      children.add(DefaultTextStyle(
          style: cellTitleStyle,
          child: label));

      if (content is Widget) {
        children.add(
            Expanded(flex: 1, child: Align(alignment: align, child: content)));
      }
    } else {
      children = [Expanded(flex: 1, child: content)];
    }

    // footer
    if (footer != null) {
      children.add(Padding(padding: EdgeInsets.only(left: 5), child: footer));
    }


    final child = Container(
        constraints: BoxConstraints(minHeight: minHeight),
        child: Padding(
            padding: EdgeInsets.only(left: _spacing, right: rightSpacing),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children)));

    if (onTap == null) {
      return child;
    }

    return InkWell(onTap: _onTap, child: child);
//    return Material(child: InkWell(onTap: _onTap, child: child));
  }
}

class _BeeCellsScope extends InheritedWidget {
  final BeeCells beeCells;

  _BeeCellsScope({
    Key key,
    child,
    this.beeCells,
  }) : super(key: key, child: child);

  static _BeeCellsScope of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(_BeeCellsScope);
  }

  @override
  bool updateShouldNotify(_BeeCellsScope oldWidget) {
    return true;
  }
}
