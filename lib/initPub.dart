// import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:flutter_umplus/flutter_umplus.dart';

/// 初始化第三方插件
Future<void> initPub() async {
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
