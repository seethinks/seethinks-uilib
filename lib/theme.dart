import 'package:flutter/material.dart';
import './src/toast/index.dart';

const Color _primaryColor = Color(0xff07C160);
const Color _primaryColorDisabled = Color(0xff06AD56);
const Color _warnColor = Color(0xffE64340);
const Color _warnColorDisabled = Color(0xffEC8B89);
const Color _defaultBackgroundColor = Color(0xfff8f8f8);
const Color _defaultBorderColor = Color(0xffd8d8d8);
const Color _lightBorderColor = Color(0xff06AD56);
const Color _maskColor = Color.fromRGBO(17, 17, 17, 0.6);
const Color _cellBackgroundColor = Color(0xffffffff);
const Color _hintColor = Color(0xff999999);
const TextStyle _cellTitleStyle = TextStyle(
    color: Colors.green,
    fontSize: 16
);

const TextStyle _actionsheetOptionsStyle = TextStyle(
    color: Colors.white,
    fontSize: 16
);

final _defaultTheme = BeeTheme();
final _defaultConfig = BeeConfig();

// 主题
class BeeTheme {
  // 主色
  final Color primaryColor;

  // 主色禁用
  final Color primaryColorDisabled;

  // 警告色
  final Color warnColor;

  // 警告色禁用
  final Color warnColorDisabled;

  // 默认背景色
  final Color defaultBackgroundColor;

  // 默认边框色
  final Color defaultBorderColor;

  // 高亮边框颜色
  final Color lightBorderColor;

  // 遮罩层颜色
  final Color maskColor;

  // 占位色
  final Color hintColor;


  final Color cellBackgroundColor;

  final TextStyle cellTitleStyle;

  final TextStyle actionsheetOptionsStyle;

  BeeTheme({this.primaryColor = _primaryColor,
    this.primaryColorDisabled = _primaryColorDisabled,
    this.warnColor = _warnColor,
    this.warnColorDisabled = _warnColorDisabled,
    this.defaultBackgroundColor = _defaultBackgroundColor,
    this.cellBackgroundColor = _cellBackgroundColor,
    this.cellTitleStyle = _cellTitleStyle,
    this.actionsheetOptionsStyle = _actionsheetOptionsStyle,
    this.defaultBorderColor = _defaultBorderColor,
    this.lightBorderColor = _lightBorderColor,
    this.maskColor = _maskColor,
    this.hintColor = _hintColor
  });
}

// 配置
class BeeConfig {
  // toast 位置
  final BeeToastInfoAlign toastInfoAlign;

  // toast info自动关闭时间
  final int toastInfoDuration;

  // toast loading关闭时间
  final int toastLoadingDuration;

  // toast success关闭时间
  final int toastSuccessDuration;

  // toast fail关闭时间
  final int toastFailDuration;

  // notify自动关闭时间
  final int notifyDuration;

  // notify成功关闭时间
  final int notifySuccessDuration;

  // notify错误关闭时间
  final int notifyErrorDuration;

  BeeConfig({
    this.toastInfoAlign = BeeToastInfoAlign.center,
    this.toastInfoDuration = 2500,
    this.toastLoadingDuration,
    this.toastSuccessDuration = 2500,
    this.toastFailDuration = 2500,
    this.notifyDuration = 3000,
    this.notifySuccessDuration = 3000,
    this.notifyErrorDuration = 3000,
  });
}

class BeeUi extends InheritedWidget {
  final BeeTheme theme;
  final BeeConfig config;

  BeeUi({Key key, this.theme, this.config, Widget child})
      : super(key: key, child: child);

  static BeeUi of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(BeeUi);
  }

  // 获取主题配置
  static BeeTheme getTheme(BuildContext context) {
    final BeeUi beeui = BeeUi.of(context);
    return beeui == null || beeui.theme == null ? _defaultTheme : beeui.theme;
  }

  // 获取全局配置
  static BeeConfig getConfig(BuildContext context) {
    final BeeUi beeui = BeeUi.of(context);
    return beeui == null || beeui.config == null
        ? _defaultConfig
        : beeui.config;
  }

  @override
  bool updateShouldNotify(BeeUi oldWidget) {
    return true;
  }
}
