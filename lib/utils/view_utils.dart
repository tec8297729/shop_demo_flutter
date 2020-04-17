import 'package:flutter_umplus/flutter_umplus.dart';

class ViewUtils {
  /// 埋点统计开始
  static beginPageView(String name) async {
    await FlutterUmplus.beginPageView(name);
  }

  /// 埋点统计结束
  static endPageView(String name) async {
    await FlutterUmplus.endPageView(name);
  }
}
