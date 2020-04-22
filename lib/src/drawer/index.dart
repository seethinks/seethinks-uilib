import 'package:flutter/material.dart';
import '../util/index.dart';
import './drawer.dart';

export './drawer.dart';

typedef ShowDrawer = Function(
    {
    // 是否显示mask
    bool mask,
    // 遮罩层点击关闭
    bool maskClosable,

    Function onClose,
    // 方向
    BeeModalPlacement placement,
    // 内容
    @required Widget child});
typedef CloseDrawer = Function();

class BeeModal {
  static ShowDrawer show(BuildContext context) {
    final GlobalKey widgetKey = GlobalKey();

    CloseDrawer showDrawer(
        {mask = true,
        maskClosable = true,
        placement = BeeModalPlacement.left,
        onClose,
        child}) {
      Function remove;

      // 关闭方法
      close([params]) async {
        // 反向执行动画
        await (widgetKey.currentState as DrawerWidgetState).reverseAnimation();
        // 执行回调
        if (onClose is Function) onClose(params);
        // 销毁
        remove();
      }

      remove = createOverlayEntry(
          context: context,
          child: DrawerWidget(
              key: widgetKey,
              mask: mask,
              placement: placement,
              maskClick: maskClosable ? close : null,
              child: child),
          willPopCallback: close);

      return close;
    }

    return showDrawer;
  }
}
