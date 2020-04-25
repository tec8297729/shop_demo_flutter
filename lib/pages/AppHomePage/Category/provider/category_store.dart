import 'package:flutter/material.dart';

class CategoryStore with ChangeNotifier {
  List rigthNavChildList = []; // 右侧顶部子菜单数据
  int navSelectIndex = 0; // 右侧顶选中数据
  Map leftSelect = {}; // 左侧选中数据
  bool isShow = false;

  // 隐藏骨架屏
  void setSkeWidget([bool flag = true]) {
    isShow = flag;
    notifyListeners();
  }

  // 设置左侧选择菜单数据
  void setLeftSelect(data) => leftSelect = data;

  // 右侧设置nav点击选中值
  void setNavSelectIndex(int index) {
    navSelectIndex = index;
    notifyListeners();
  }

  // 设置子分类菜单数据
  void setChildCategory(List list, {String mallSubId}) {
    setSkeWidget(false);
    // 插入一条子类 全部，带参数
    Map allData = {
      'mallSubId': '',
      'mallCategoryId': '',
      'comments': 'null',
      'mallSubName': '全部',
    };
    rigthNavChildList = [allData, ...list];
    notifyListeners();
  }
}
