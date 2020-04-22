import 'package:flutter/material.dart';
import '../cell.1.dart';

class BeeForm extends StatefulWidget {
  final bool boxBorder;
  final bool splitBorder;
  final double spacing;
  final double lineSpacing;
  final double height;
  final List<Widget> children;

  BeeForm({key,
    this.boxBorder = true,
    this.splitBorder = true,
    this.spacing = labelSpacing,
    this.lineSpacing = 0,
    this.height = 50,
    @required this.children})
      : super(key: key);

  static BeeFormState of(BuildContext context) {
    final BeeFormScope scope = context.inheritFromWidgetOfExactType(
        BeeFormScope);
    return scope?.state;
  }

  @override
  BeeFormState createState() => BeeFormState();
}

class BeeFormState extends State<BeeForm> {
  final Map<dynamic, dynamic> formValue = {};

  // 设置表单值
  void setValue(Map<dynamic, dynamic> value) {
    setState(() {
      formValue.addAll(value);
    });
  }

  validate() {}

  @override
  Widget build(BuildContext context) {
    bool boxBorder = widget.boxBorder;
    if (!widget.splitBorder) {
      boxBorder = false;
    }
    return BeeFormScope(
        state: this,
        formValue: formValue,
        child: BeeCells(
            lineSpacing: widget.lineSpacing,
            boxBorder: boxBorder,
            splitBorder: widget.splitBorder,
            spacing: widget.spacing,
            children: widget.children));
  }
}

class BeeFormScope extends InheritedWidget {
  final BeeFormState state;
  final formValue;

  BeeFormScope({Key key, this.state, this.formValue, Widget child})
      : super(key: key, child: child);

  static BeeFormScope of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(BeeFormScope);
  }

  //是否重建widget就取决于数据是否相同
  @override
  bool updateShouldNotify(BeeFormScope oldWidget) {
    return formValue != oldWidget.formValue;
  }
}
