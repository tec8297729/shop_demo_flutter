import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeStore extends ChangeNotifier {
  ScrollController homeScrollControll;
  GlobalKey sliverListTopKey = GlobalKey();

  /// 保存home页面滚动控制器
  saveController(ScrollController controller) {
    homeScrollControll = controller;
  }

  /// 获取homd页面滚动控制器
  ScrollController get getHomeController => homeScrollControll;

  GlobalKey get getSliverListTopKey => sliverListTopKey;

  double getTopHeight() {
    RenderObject renderObject =
        sliverListTopKey.currentContext.findRenderObject();
    SliverConstraints constraints = renderObject.constraints;
    // print(constraints.remainingCacheExtent);
    return constraints.remainingCacheExtent;
  }
}
