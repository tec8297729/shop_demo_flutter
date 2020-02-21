import 'package:flutter_umplus/flutter_umplus.dart';

class ViewUtils {
  static beginPageView(String name) {
    FlutterUmplus.beginPageView(name);
  }

  static endPageView(String name) {
    FlutterUmplus.endPageView(name);
  }
}
