import 'package:baixing/constants/themes/themeBlueGrey.dart';
import 'package:flutter/material.dart';

class ThemeStore with ChangeNotifier {
  ThemeData _themeData = themeBlueGrey;

  // 更新全局主题样式
  void setTheme(ThemeData themeName) {
    _themeData = themeName;
    notifyListeners();
  }

  ThemeData get getTheme => _themeData;
}
