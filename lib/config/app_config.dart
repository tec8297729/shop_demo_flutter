import 'package:baixing/routes/RouteName.dart';

class AppConfig {
  static const DEBUG = false; // 是否开启调试打印
  /// 是否直接跳过闪屏页面，
  static const notSplash = false;

  /// 刷新后直达某页面，方便调试，需notSplash参数为true才有效果
  static String directPageName = RouteName.loginPage;

  static const printFlag = true; // 是否允许打印print

  /// dio请求前缀
  static String host = '/';

  /// 是否启用代理
  static const usingProxy = false;

  /// 代理的 ip 地址
  static const proxyAddress = '192.168.2.201';

  /// 代理端口
  static const proxyPort = 9999;
}
