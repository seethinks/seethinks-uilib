import 'package:beeui/bee.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BeeLoading extends StatelessWidget {
  final double size;
  BeeLoading({this.size = 80});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: new Center(child: new CircularProgressIndicator()),
    );
  }
}

class BeeNoData extends StatelessWidget {
  final String msg;

  BeeNoData({this.msg = "暂无数据"});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              BeeIcon.noData,
              size: 40,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(msg, style: TextStyle(fontSize: 12)),
            )
          ]),
    );
  }
}

class RefresherHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaterDropHeader(
        refresh: BeeLoading(
      size: 50,
    ));
  }
}

class RefresherFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      loadingIcon: BeeLoading(
        size: 40,
      ),
      failedText: "加载失败,请点击重试",
      idleText: "上拉加载更多",
      loadingText: "加载中...",
      noDataText: "没有更多数据了",
    );
  }
}
