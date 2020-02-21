import 'package:flutter_umplus/flutter_umplus.dart';

class ViewUtils {
  static beginPageView(String name) async {
    await FlutterUmplus.beginPageView(name);
  }

  static endPageView(String name) async {
    await FlutterUmplus.endPageView(name);
  }
}
