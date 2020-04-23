import 'package:ana_page_loop/ana_page_loop.dart' show anaPageLoop;
import 'package:baixing/utils/util.dart';
// import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:flutter_umplus/flutter_umplus.dart';

/// 初始化app需要的插件等功能
void myAppSetup() {
  _umplusInit();
  _anaPageLoopInit();
}

/// 初始化埋点统计插件
void _anaPageLoopInit() {
  anaPageLoop.init(
    beginPageFn: (name) {
      ViewUtils.beginPageView(name);
    },
    endPageFn: (name) {
      ViewUtils.endPageView(name);
    },
    routeRegExp: ['/home'], // 过滤路由  /accountPage
    debug: true,
  );
}

/// 初始化友盟统计
Future<void> _umplusInit() async {
  // 友盟统计
  FlutterUmplus.init(
    '5e1efe324ca357f674000796',
    channel: '',
    reportCrash: false,
    logEnable: true,
    encrypt: true,
  );

  // AmapCore.init('3c3a88134c8307656276aa78e8e1a747'); // 高德定位插件
}
