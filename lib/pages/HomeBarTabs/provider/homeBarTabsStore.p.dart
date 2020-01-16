import 'package:flutter/material.dart';

class HomeBarTabsStore extends ChangeNotifier {
  PageController barTabsController;
  int _tabPage = 0;

  // 保存页面控制器
  saveController(PageController barTabsCont) => barTabsController = barTabsCont;

  // 获取获取器
  PageController get getBarTabsCont => barTabsController;

  // 获取首页tabs当前值
  int get getTabPage => _tabPage;

  // 设置首页tabs显示的tabs
  setTabPage(int index) async {
    _tabPage = index;
    notifyListeners();
  }
}
