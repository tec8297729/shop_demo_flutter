import '../pages/SplashPage/SplashPage.dart';
import 'package:flutter/material.dart';
import '../pages/HomeBarTabs/HomeBarTabs.dart';
import '../pages/GoodsDetailsInfo/GoodsDetailsInfo.dart';
import '../pages/SearchPage/SearchPage.dart';
import '../pages/AmapPage/AmapPage.dart';
import '../pages/AmapPage/components/SearchGeocodePage.dart';
import '../pages/ErrorPage/ErrorPage.dart';
import '../pages/FlowLayout/FlowLayout.dart';

final String initialRoute = '/'; // 初始默认显示的路由
final Map<String, WidgetBuilder> routesInit = {
  // 页面路由定义...
  '/': (BuildContext context, {params}) => SplashPage(),
  '/home': (BuildContext context, {params}) => HomeBarTabs(params: params),
  '/error': (BuildContext context, {params}) => ErrorPage(params: params),
  // 商品详情页
  '/goodsDetailsInfo': (BuildContext context, {params}) =>
      GoodsDetailsInfo(params: params),
  // 地图
  '/amapPage': (BuildContext context) => AmapPage(),
  // 地图坐标查询测试
  '/searchGeocodePage': (BuildContext context) => SearchGeocodePage(),
  // 搜索页面
  '/searchPage': (BuildContext context, {params}) => SearchPage(params: params),
  '/flowLayout': (BuildContext context, {params}) => FlowLayout(),
};
