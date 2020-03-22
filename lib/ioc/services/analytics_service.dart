import 'package:baixing/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:synchronized/synchronized.dart';

// 埋点统计
class AnalyticsService {
  Route newRouteConfig;
  Route oldRouteConfig;
  Lock lock = new Lock();

  // 处理数据埋点上报,过渡home及广告闪屏页
  _buriedPrint(Route newRoute, Route oldRoute) async {
    await lock.synchronized(() {
      String newRouteName = newRoute?.settings?.name;
      String oldRouteName = oldRoute?.settings?.name;
      // 获取路由的名字
      LogUtil.p('push进入页面 = $newRouteName');
      LogUtil.p('上一页面 = $oldRouteName');
      LogUtil.p('参数 = ${newRoute?.settings?.arguments}');

      bool newRouteReg =
          RegExp(r"^(null|/|/home)$").hasMatch(newRouteName ?? "null");
      bool oldRouteReg =
          RegExp(r"^(null|/|/home)$").hasMatch(oldRouteName ?? "null");

      LogUtil.p('newRouteReg>>>$newRouteReg');
      // LogUtil.p('oldRouteReg>>>${oldRouteReg}');
      if (newRouteName == null ||
          oldRouteName == null ||
          newRouteName == oldRouteName) {
        LogUtil.p('阻止');
        return;
      }

      if (!oldRouteReg) {
        // 结束统计
        ViewUtils.endPageView(oldRouteName);
      }
      if (!newRouteReg) {
        // 开始统计
        ViewUtils.beginPageView(newRouteName);
      }
    });
  }

  /// 统计页面正常跳转
  appPush(Route newRoute, Route oldRoute) async {
    await _buriedPrint(newRoute, oldRoute);
    newRouteConfig = newRoute;
    oldRouteConfig = oldRoute;
  }

  // app后台状态统计
  appPaused() async {
    _buriedPrint(newRouteConfig, oldRouteConfig);
  }
}
