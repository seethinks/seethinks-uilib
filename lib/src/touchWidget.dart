import 'package:flutter/material.dart';

class TouchWidget extends StatelessWidget {
  Widget child;

//
  Function onTap;

  TouchWidget({this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: child,
        onTap: () {
          if (onTap is Function) {
            onTap();
          }
        });
  }
}
