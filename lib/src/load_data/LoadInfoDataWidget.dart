import 'package:beeui/src/util/provider/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../bee.dart';
import '../loding.dart';

class LoadInfoDataWidget<T extends ViewStateInfoModel> extends StatelessWidget {
  // 数据
  final T model;

  final Function renderHandler;

  //加载中组件
  final Widget loadingWidget;

  //顶部加载组件
  final WaterDropHeader refresherHeader;

  LoadInfoDataWidget({@required this.model,
    @required this.renderHandler,
    this.loadingWidget,
    this.refresherHeader});

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<T>(
        model: model,
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.busy) {
            return loadingWidget != null ? loadingWidget : Center(
              child: BeeLoading(),
            );
          }
          if (model.error) {
            return Center(
              child: LoadErrorWidget(onPressed: model.initData),
            );
          }

          return renderHandler(model.data);
        });
  }
}
