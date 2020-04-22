import 'package:flutter/material.dart';

import '../../bee.dart';

// 方向
enum IconTextPlacement { horizontal, vertical }

class IconText extends StatelessWidget {
  // icon
  final dynamic icon;

  // 文本
  final dynamic text;

  // 布局方式
  final IconTextPlacement placement;

  // 是否反转
  final bool reversal;

  final Function onTap;

  // 留白
  final double space;

  IconText({this.icon,
    this.text,
    this.placement: IconTextPlacement.horizontal,
    this.onTap,
    this.space = 5,
    this.reversal: false});

  @override
  Widget build(BuildContext context) {
    List<Widget> arr = [];

    if (icon is Widget) {
      var _padding = EdgeInsets.only(right: space);
      if (placement == IconTextPlacement.vertical) {
        _padding = !reversal ? EdgeInsets.only(bottom: space) : EdgeInsets.only(
            top: space);
      } else {
        _padding = !reversal ? EdgeInsets.only(right: space) : EdgeInsets.only(
            left: space);
      }

      arr.add(Padding(
        child: icon,
        padding: _padding,
      ));
    }

    if (text != null) {
      arr.add(toTextWidget(text, "key"));
    }

    if (icon != null && text != null && reversal) {
      arr = arr.reversed.toList();
    }

    return GestureDetector(
      onTap: onTap,
      child: placement == IconTextPlacement.horizontal
          ? Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: arr,
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: arr,
      ),
    );
  }
}
