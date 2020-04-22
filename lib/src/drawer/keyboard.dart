import 'package:flutter/material.dart';

class BeeKeyBoard extends StatefulWidget {
  @override
  _BeeKeyBoardState createState() => _BeeKeyBoardState();
}

class _BeeKeyBoardState extends State<BeeKeyBoard> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }

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
}