import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeStore extends ChangeNotifier {
  ScrollController homeScrollControll;
  GlobalKey sliverListTopKey = GlobalKey();
  bool isShow = false;
  double _myAppBarHeight = 0;
  double _topTitleHeight = 0;

  /// 保存MyAppBar组件高度，带安全边距
  saveMyAppBarHeight(double height) => _myAppBarHeight = height;

  /// 保存滚动置顶组件的高度
  saveTopTitleHeight(double height) => _topTitleHeight = height;

  /// topTitle组件中的弹层定位top位置
  get showTopTItleHeight => _myAppBarHeight + _topTitleHeight;

  // 隐藏骨架屏, true隐藏
  void setSkeWidget([bool flag = true]) {
    isShow = flag;
    notifyListeners();
  }

  /// 保存home页面滚动控制器
  saveController(ScrollController controller) {
    homeScrollControll = controller;
  }

  /// 获取homd页面滚动控制器
  ScrollController get getHomeController => homeScrollControll;

  setSliverListTopKey(key) => sliverListTopKey = key;
  GlobalKey get getSliverListTopKey => sliverListTopKey;

  /// 滚动顶部距离计算
  double getTopHeight() {
    RenderObject renderObject =
        sliverListTopKey?.currentContext?.findRenderObject();
    SliverConstraints constraints = renderObject?.constraints;
    return constraints.remainingCacheExtent;
  }
}
