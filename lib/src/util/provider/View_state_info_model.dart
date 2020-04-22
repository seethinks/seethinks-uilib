import 'view_state_model.dart';

/// 基于
abstract class ViewStateInfoModel<T> extends ViewStateModel {
  /// 页面数据
  T data;

  /// 第一次进入页面loading skeleton
  initData() async {
    setBusy();
    await _loadData(init: true);
  }

  _loadData({bool init = false}) async {
    try {
      data = await loadData();
      onCompleted(data);
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  // 加载数据
  loadData();


  onCompleted(data) {}
}
