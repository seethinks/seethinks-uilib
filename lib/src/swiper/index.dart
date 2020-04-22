import 'package:flutter/material.dart';
import 'dart:async';

class BeeSwiper extends StatefulWidget {
  final GlobalKey key;

  // 数量
  final int itemCount;

  // 渲染每个item
  final Widget Function(int index) itemBuilder;

  // 宽度
  final double width;

  // 高度
  final double height;

  // 默认展示
  final int defaultIndex;

  // 循环
  final bool loop;

  // 是否显示指示
  final bool indicators;

  // 自动播放时间
  final int playDuration;

  // 自动播放
  final bool autoPlay;

  // 动画过度时间
  final int duration;

  // 动画过度曲线
  final Curve curve;

  final Function renderIndicator;

  final Rect indicatorPosotion;

  //滚动方向
  final Axis scrollDirection;

  // 回调
  final Function(int index) onChang;

  BeeSwiper({this.key,
    @required this.itemCount,
    @required this.itemBuilder,
    this.width,
    this.height,
    this.defaultIndex = 0,
    this.loop = true,
    this.indicators = true,
    this.playDuration = 3000,
    this.autoPlay = true,
    this.duration = 280,
    this.renderIndicator,
    this.indicatorPosotion,
    this.curve = Curves.bounceIn,
    this.scrollDirection = Axis.horizontal,
    this.onChang})
      : super(key: key);

  @override
  BeeSwipeState createState() => BeeSwipeState();
}

class BeeSwipeState extends State<BeeSwiper> {
  PageController _pageController;
  int _index;
  Timer _timer;
  List<Widget> children = [];
  List<Widget> _list = [];

  @override
  void initState() {
    super.initState();
    // 生成列表
    final List<Widget> children = [];
    for (int index = 0; index < widget.itemCount; index++) {
      children.add(widget.itemBuilder(index));
    }
    // 判断是否循环
    if (widget.loop) {
      _index = widget.defaultIndex + 1;
      _list.addAll(children);
      _list.add(children[0]);
      _list.insert(0, children[widget.itemCount - 1]);
    } else {
      _list = children;
      _index = widget.defaultIndex;
    }

    // PageController
    _pageController = PageController(initialPage: _index);

    // 自动播放
    if (widget.autoPlay) {
      this.autoPlay();
    }
  }

  @override
  void dispose() {
    super.dispose();
    stopAutoPlay();
  }

  // 设置展示的索引
  void setIndex(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: widget.duration), curve: widget.curve);
  }

  // 上一页
  void previousPage() {
    _pageController.previousPage(
        duration: Duration(milliseconds: widget.duration), curve: widget.curve);
  }

  // 下一页
  void nextPage() {
    _pageController.nextPage(
        duration: Duration(milliseconds: widget.duration), curve: widget.curve);
  }

  void onChang(int index) {
    if (widget.onChang != null) {
      widget.onChang(index);
    }

    setState(() {
      _index = index;
    });
  }

  // 渲染indicators
  List<Widget> renderIndicators(int index) {
    final List<Widget> indicators = [];
    final double size = 7.0;

    for (var i = 0; i < widget.itemCount; i++) {
      if (widget.renderIndicator == null) {
        indicators.add(Padding(
            padding: EdgeInsets.only(left: i == 0 ? 0.0 : 7.0),
            child: Opacity(
                opacity: index == i ? 1.0 : 0.55,
                child: SizedBox(
                    width: size,
                    height: size,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(size))))))));
      } else {
        indicators.add(widget.renderIndicator(index == i));
      }
    }
    return indicators;
  }

  // 自动播放
  void autoPlay() {
    _timer = Timer.periodic(Duration(milliseconds: widget.playDuration),
            (Timer timer) {
          if (widget.loop) {
            if (_index == widget.itemCount) {
              _pageController.jumpToPage(0);
            }
            nextPage();
          } else if (_index == widget.itemCount - 1) {
            setIndex(0);
          } else {
            nextPage();
          }
        });
  }

  // 停止自动播放
  void stopAutoPlay() {
    _timer?.cancel();
    _timer = null;
  }

  // 按下
  onPointerDown(event) {
    if (widget.autoPlay) {
      stopAutoPlay();
    }

    // 边界值判断
    if (_index == widget.itemCount + 1) {
      _pageController.jumpToPage(1);
    }
  }

  // 抬起
  onPointerUp(event) {
    if (widget.autoPlay) {
      autoPlay();
    }

    // 边界值判断
    if (_index == 0) {
      _pageController.jumpToPage(widget.itemCount);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget swipeWidget = PageView.builder(
        itemCount: _list.length,
        controller: _pageController,
        scrollDirection: widget.scrollDirection,
        onPageChanged: onChang,
        itemBuilder: (BuildContext context, int index) {
          return _list[index];
        });

    // 判断是否循环
    if (widget.loop) {
      swipeWidget = Listener(
          onPointerDown: onPointerDown,
          onPointerUp: onPointerUp,
          child: swipeWidget);
    }

    // 判断是否显示指示
    if (widget.indicators) {
      swipeWidget = Stack(children: <Widget>[
        swipeWidget,
        // indicators
        Positioned(
            left: widget.indicatorPosotion == null ? 0 : widget
                .indicatorPosotion.left,
            right: widget.indicatorPosotion == null ? 0 : widget
                .indicatorPosotion.right,
            bottom: widget.indicatorPosotion == null ? 20 : widget
                .indicatorPosotion.bottom,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: renderIndicators(widget.loop ? _index - 1 : _index)))
      ]);
    }

    return SizedBox(
        width: widget.width, height: widget.height, child: swipeWidget);
  }
}
