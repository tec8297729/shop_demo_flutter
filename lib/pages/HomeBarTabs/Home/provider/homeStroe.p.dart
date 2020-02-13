import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeStore extends ChangeNotifier {
  ScrollController homeScrollControll;
  GlobalKey sliverListTopKey = GlobalKey();
  bool isShow = false;

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

  double getTopHeight() {
    RenderObject renderObject =
        sliverListTopKey?.currentContext?.findRenderObject();
    SliverConstraints constraints = renderObject?.constraints;
    return constraints.remainingCacheExtent;
  }
}
