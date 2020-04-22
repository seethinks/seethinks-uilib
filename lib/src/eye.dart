import 'package:beeui/src/icon.dart';
import 'package:flutter/material.dart';

class Eye extends StatefulWidget {
  final Function onChange;
  final bool defaultOpen;
  final double size;

  const Eye({Key key, this.onChange, this.defaultOpen = true, this.size = 20})
      : super(key: key);

  @override
  _EyeState createState() => _EyeState();
}

class _EyeState extends State<Eye> {
  bool _status;

  @override
  void initState() {
    _status = widget.defaultOpen;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
//      borderRadius: BorderRadius.circular(2),
      onTap: () {
        setState(() {
          _status = !_status;
        });
        if (widget.onChange is Function) {
          widget.onChange(_status);
        }
      },
      child: Icon(
        _status ? BeeIcon.eyeOpen : BeeIcon.eyeClose,
        size: widget.size,
      ),
    );
  }
}
