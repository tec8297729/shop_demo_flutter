import 'package:baixing/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:synchronized/synchronized.dart';
import 'package:flutter_umplus/flutter_umplus.dart';

// 埋点统计
class AnalyticsService {
  Route newRouteConfig;
  Route oldRouteConfig;
  Lock lock = new Lock();

  // 处理数据埋点上报
  _buriedPrint(Route newRoute, Route oldRoute) async {
    await lock.synchronized(() {
      String newRouteName = newRoute?.settings?.name;
      String oldRouteName = oldRoute?.settings?.name;
      // 获取路由的名字
      LogUtil.d('push进入页面 = ${newRoute?.settings?.name}');
      LogUtil.d('上一页面 = ${oldRoute?.settings?.name}');

      if (newRouteName == null ||
          oldRouteName == null ||
          newRouteName == oldRouteName) {
        LogUtil.d('阻止');
        return;
      }

      // 开始统计
      FlutterUmplus.beginPageView(newRouteName);
      if (oldRouteName != null) {
        // 结束统计
        FlutterUmplus.endPageView(oldRouteName);
      }
    });
  }

  /// 统计页面正常跳转
  appPush(Route newRoute, Route oldRoute) async {
    _buriedPrint(newRoute, oldRoute);
    newRouteConfig = newRoute;
    oldRouteConfig = oldRoute;
  }

  // app后台状态统计
  appPaused() async {
    _buriedPrint(newRouteConfig, oldRouteConfig);
  }
}
