import 'package:flutter/material.dart';
import '../enums.dart';
import 'button.dart';
import 'icon.dart';

enum LoaderState { NoAction, Loading, Succeed, Failed, NoData }

class LoaderContainer extends StatefulWidget {
  LoaderContainer({
    Key key,
    @required this.contentView,
    this.loadingView,
    this.errorView,
    this.emptyView,
    @required this.loaderState,
    this.onReload,
  }) : super(key: key);

  final LoaderState loaderState;
  final Widget loadingView;
  final Widget errorView;
  final Widget emptyView;
  final Widget contentView;
  final Function onReload;

  @override
  State createState() => _LoaderContainerState();
}

class _LoaderContainerState extends State<LoaderContainer> {
  @override
  Widget build(BuildContext context) {
    Widget currentWidget;
    switch (widget.loaderState) {
      case LoaderState.Loading:
        currentWidget = widget.loadingView ?? _ClassicalLoadingView();
        break;
      case LoaderState.Failed:
        currentWidget = widget.errorView ??
            _ClassicalErrorView(
              onReload: () => widget.onReload(),
            );
        break;
      case LoaderState.NoData:
        currentWidget = widget.emptyView ?? _ClassicalNoDataView();
        break;
      case LoaderState.Succeed:
      case LoaderState.NoAction:
        currentWidget = widget.contentView;
        break;
    }
    return currentWidget;
  }
}

class _ClassicalLoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              strokeWidth: 3.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                '加载中',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );
}

class _ClassicalErrorView extends StatelessWidget {
  _ClassicalErrorView({@required this.onReload}) : super();

  final Function onReload;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              BeeIcon.netError,
              size: 100,
              color: Colors.grey[500],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                '亲的网络有点问题~',
                style: TextStyle(fontSize: 12.0, color: Colors.grey[400]),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            BeeButton(
              "重新加载",
              hollow: true,
              onTap: onReload,
              radius: 30,
            )
          ],
        ),
      );
}

class _ClassicalNoDataView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              BeeIcon.noData,
              size: 70,
              color: Colors.grey[300],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                '暂无数据',
                style: TextStyle(fontSize: 12.0, color: Colors.grey[400]),
              ),
            )
          ],
        ),
      );
}
