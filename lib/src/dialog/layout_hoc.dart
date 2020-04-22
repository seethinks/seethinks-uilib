import 'package:flutter/material.dart';
import '../animation/fade_in.dart';
import '../animation/scale.dart';
import 'dart:ui' as ui;

final double boxPadding = 25.0;

class CustomLayoutHoc extends StatefulWidget {
  final GlobalKey scaleKey;
  final GlobalKey fadeInKey;
  final List<Widget> children;
  final Color maskColor;

  CustomLayoutHoc(
      {this.scaleKey, this.fadeInKey, this.children, this.maskColor});

  @override
  _CustomLayoutHocState createState() => _CustomLayoutHocState();
}

class _CustomLayoutHocState extends State<CustomLayoutHoc>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (this.mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQueryData.fromWindow(ui.window);
    return FadeIn(
        key: widget.fadeInKey,
        duration: 150,
        child: Stack(alignment: Alignment.center, children: [
          Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: DecoratedBox(
                  decoration: BoxDecoration(color: widget.maskColor))),
          AnimatedContainer(
            color: Colors.transparent,
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom),
            child: Padding(
                padding: EdgeInsets.only(left: 37.0, right: 37.0),
                child: Scale(
                    key: widget.scaleKey,
                    begin: 0.85,
                    end: 1.0,
                    child: Material(
//                    color: theme,
                        borderRadius:
                        BorderRadius.all(Radius.circular(3.0)),
                        child: Padding(
                            padding: EdgeInsets.only(top: boxPadding - 4),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: widget.children))))),
            alignment: Alignment.center,
          )
        ]));
  }
}

// layoutHoc(
//     {@required GlobalKey scaleKey,
//     @required GlobalKey fadeInKey,
//     @required List<Widget> children,
//     @required Color maskColor}) {
//   return FadeIn(
//       key: fadeInKey,
//       duration: 150,
//       child: Stack(alignment: Alignment.center, children: [
//         Positioned(
//             top: 0,
//             right: 0,
//             bottom: 0,
//             left: 0,
//             child: DecoratedBox(decoration: BoxDecoration(color: maskColor))),
//         Padding(
//             padding: EdgeInsets.only(left: 37.0, right: 37.0),
//             child: Scale(
//                 key: scaleKey,
//                 begin: 0.85,
//                 end: 1.0,
//                 child: Material(
// //                    color: theme,
//                     borderRadius: BorderRadius.all(Radius.circular(3.0)),
//                     child: Padding(
//                         padding: EdgeInsets.only(top: boxPadding - 4),
//                         child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: children)))))
//       ]));
// }
