import 'package:beeui/src/util/provider/provider_widget.dart';
import 'package:beeui/src/util/provider/view_state_refresh_list_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../bee.dart';
import '../loding.dart';

class LoadListDataWidget<T extends ViewStateRefreshListModel>
    extends StatefulWidget {
  // 数据
  final T model;

  // 初始化数据
  final Function initData;

  // 渲染单个函数
  final Function renderItem;

  //加载中组件
  final Widget loadingWidget;

  //顶部加载组件
  final WaterDropHeader refresherHeader;

  final bool isScroll;

  //底部加载组件
  final ClassicFooter refresherFooter;

  LoadListDataWidget({@required this.model,
    @required this.initData,
    @required this.renderItem,
    this.loadingWidget,
    this.isScroll = true,
    this.refresherHeader,
    this.refresherFooter});

  @override
  _LoadDataListWidgetState createState() => _LoadDataListWidgetState();
}

class _LoadDataListWidgetState<T extends ViewStateRefreshListModel>
    extends State<LoadListDataWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final physics = widget.isScroll
        ? new AlwaysScrollableScrollPhysics()
        : new NeverScrollableScrollPhysics();

    return ProviderWidget<T>(
        model: widget.model,
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.busy) {
            return widget.loadingWidget != null
                ? widget.loadingWidget
                : BeeLoading();
          }
          if (model.error) {
            return LoadErrorWidget(onPressed: model.initData);
          }

          if (model.empty) {
            return BeeNoData();
          }

          var _list = model.list;
          return SmartRefresher(
              controller: model.refreshController,
              header: widget.refresherHeader != null
                  ? widget.refresherHeader
                  : RefresherHeader(),
              footer: widget.refresherFooter != null
                  ? widget.refresherFooter
                  : RefresherHeader(),
              onRefresh: model.refresh,
              onLoading: model.loadMore,
              enablePullUp: true,
              enablePullDown: true,
              child: ListView.separated(
                physics: physics,
                separatorBuilder: (BuildContext context, int index) =>
                new Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return widget.renderItem(model.list[index]);
                },
                itemCount: _list.length,
              ));
        });
  }
}
