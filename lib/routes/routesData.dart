import 'package:baixing/pages/ActivityPage/ActivityPage.dart';
import 'package:flutter/material.dart';
import 'RouteName.dart';
import '../pages/HomeBarTabs/HomeBarTabs.dart';
import '../pages/GoodsDetailsInfo/GoodsDetailsInfo.dart';
import '../pages/SearchPage/SearchPage.dart';
import '../pages/AmapPage/AmapPage.dart';
import '../pages/AmapPage/components/SearchGeocodePage.dart';
import '../pages/ErrorPage/ErrorPage.dart';
import '../pages/FlowLayout/FlowLayout.dart';
import '../pages/AdH5View/AdH5View.dart';
import '../pages/AccountPage/AccountPage.dart';
import '../pages/LoginPage/LoginPage.dart';
import '../pages/PasswordPage/PasswordPage.dart';
import '../pages/SpeakPage/SpeakPage.dart';
import '../pages/SplashPage/SplashPage.dart';

// 全局的路由监听者，可在需要的widget中添加，应该放到一个全局定义的文件中
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final String initialRoute = RouteName.splashPage; // 初始默认显示的路由

final Map<String, WidgetBuilder> routesData = {
  RouteName.splashPage: (BuildContext context, {params}) => SplashPage(),
  RouteName.home: (BuildContext context, {params}) =>
      HomeBarTabs(params: params),
  RouteName.error: (BuildContext context, {params}) =>
      ErrorPage(params: params),
  RouteName.goodsDetailsInfo: (BuildContext context, {params}) =>
      GoodsDetailsInfo(params: params),
  RouteName.amapPage: (BuildContext context) => AmapPage(),
  RouteName.searchGeocodePage: (BuildContext context) => SearchGeocodePage(),
  RouteName.searchPage: (BuildContext context, {params}) =>
      SearchPage(params: params),
  RouteName.flowLayout: (BuildContext context, {params}) => FlowLayout(),
  RouteName.speakPage: (BuildContext context, {params}) => SpeakPage(),
  RouteName.passwordPage: (BuildContext context, {params}) => PasswordPage(),
  RouteName.accountPage: (BuildContext context, {params}) => AccountPage(),
  RouteName.adH5View: (BuildContext context, {params}) =>
      AdH5View(params: params),
  RouteName.loginPage: (BuildContext context, {params}) => LoginPage(),
  RouteName.activityPage: (BuildContext context, {params}) => ActivityPage(),
};
