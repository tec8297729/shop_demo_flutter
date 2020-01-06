import 'package:baixing/pages/AmapPage/AmapPage.dart';
import 'package:baixing/pages/AmapPage/components/SearchGeocodePage.dart';
import 'package:baixing/pages/ErrorPage/ErrorPage.dart';
import 'package:flutter/material.dart';
// 以下各路由页面显示的组件
import 'package:baixing/pages/BarTabs/BarTabs.dart';
import 'package:baixing/pages/GoodsDetailsInfo/GoodsDetailsInfo.dart';
import 'package:baixing/pages/SearchPage/SearchPage.dart';

final String initialRoute = '/'; // 初始默认显示的路由
final Map<String, WidgetBuilder> routesInit = {
  // 页面路由定义...
  '/': (BuildContext context, {params}) => BarTabs(params: params),
  '/error': (BuildContext context, {params}) => ErrorPage(params: params),
  // 商品详情页
  '/goodsDetailsInfo': (BuildContext context, {params}) =>
      GoodsDetailsInfo(params: params),
  // 地图
  '/amapPage': (BuildContext context) => AmapPage(),
  // 地图坐标查询测试
  '/searchGeocodePage': (BuildContext context) => SearchGeocodePage(),
  // 搜索页面
  '/searchPage': (BuildContext context) => SearchPage(),
};
