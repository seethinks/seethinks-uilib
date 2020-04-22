import 'package:flutter/material.dart';
import './android_widget.dart';
import './ios_widget.dart';
import '../util/index.dart';

// 关闭函数
typedef _Close = Function();
// change
typedef _onChange = Function(String index);
// 安卓
typedef BeeActionsheetAndroid = Function(
    {@required List<BeeActionsheetItem> options,
    _Close onClose,
    bool maskClosable,
    _onChange onChange});
// ios
typedef BeeActionsheetIos = Function(
    {dynamic title,
    @required List<BeeActionsheetItem> options,
    bool maskClosable,
    dynamic cancelButton,
    _Close onClose,
    _onChange onChange});

// WeActionsheet
class BeeActionsheet {
  // 安卓样式
  static BeeActionsheetAndroid android(BuildContext context) {
    return ({maskClosable = true, onClose, onChange, options}) {
      final GlobalKey widgetKey = GlobalKey();
      Function remove;

      // 关闭
      void hide() {
        remove();
        if (onClose is Function) {
          onClose();
        }
      }

      // 点击
      void itemClick(int index) {
        remove();
        if (onChange is Function) {
          final String value = options[index].value;
          onChange(value == null ? index.toString() : value);
        }
      }

      remove = createOverlayEntry(
          context: context,
          backIntercept: true,
          child: AndroidWidget(
              key: widgetKey,
              maskClosable: maskClosable,
              close: hide,
              onChange: itemClick,
              childer: options),
          willPopCallback: () {
            (widgetKey.currentState as AndroidWidgetState).close();
          });
    };
  }

  // ios 样式
  static BeeActionsheetIos ios(BuildContext context) {
    return (
        {title,
        options,
        maskClosable = true,
        cancelButton,
        onClose,
        onChange}) {
      final GlobalKey widgetKey = GlobalKey();
      Function remove;

      // 关闭
      void hide() {
        remove();
        if (onClose is Function) {
          onClose();
        }
      }

      // 点击
      void itemClick(int index) {
        remove();
        if (onChange is Function) {
          final String value = options[index].value;
          onChange(value == null ? index.toString() : value);
        }
      }

      remove = createOverlayEntry(
          context: context,
          backIntercept: true,
          child: IosWidget(
              key: widgetKey,
              title: title,
              cancelButton: cancelButton,
              maskClosable: maskClosable,
              close: hide,
              onChange: itemClick,
              childer: options),
          willPopCallback: () {
            (widgetKey.currentState as IosWidgetState).close();
          });
    };
  }
}

class BeeActionsheetItem {
  final label;
  final String value;

  BeeActionsheetItem({@required this.label, this.value});
}
