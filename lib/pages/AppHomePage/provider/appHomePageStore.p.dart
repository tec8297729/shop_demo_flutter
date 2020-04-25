import 'package:flutter/material.dart';

class AppHomePageStore extends ChangeNotifier {
  PageController barTabsController;
  bool _grayTheme = false;
  int _tabPage = 0;

  // 保存页面控制器
  saveController(PageController barTabsCont) => barTabsController = barTabsCont;

  // 获取获取器
  PageController get getBarTabsCont => barTabsController;

  // 获取首页tabs当前值
  int get getTabPage => _tabPage;

  /// 检测是否是指定tab页面
  bool isCurrTabPage(int page) {
    return barTabsController.page == page;
  }

  void setTabPage(int index) async {
    _tabPage = index;
    notifyListeners();
  }

  /// 是否显示灰度模式主题，true为灰度, false显示原有主题颜色
  bool setGrayTheme([bool flag = false]) {
    _grayTheme = flag;
    notifyListeners();
    return _grayTheme;
  }

  /// 是否是灰度模式
  bool get getGrayTheme => _grayTheme;
}
