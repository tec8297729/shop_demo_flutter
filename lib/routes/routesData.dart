import '../pages/LoginPage/LoginPage.dart';
import '../pages/PasswordPage/PasswordPage.dart';
import '../pages/SpeakPage/SpeakPage.dart';
import '../pages/SplashPage/SplashPage.dart';
import 'package:flutter/material.dart';
import '../pages/HomeBarTabs/HomeBarTabs.dart';
import '../pages/GoodsDetailsInfo/GoodsDetailsInfo.dart';
import '../pages/SearchPage/SearchPage.dart';
import '../pages/AmapPage/AmapPage.dart';
import '../pages/AmapPage/components/SearchGeocodePage.dart';
import '../pages/ErrorPage/ErrorPage.dart';
import '../pages/FlowLayout/FlowLayout.dart';
import 'routerName.dart';

final String initialRoute = RouterName.splashPage; // 初始默认显示的路由

final Map<String, WidgetBuilder> routesData = {
  RouterName.splashPage: (BuildContext context, {params}) => SplashPage(),
  RouterName.home: (BuildContext context, {params}) =>
      HomeBarTabs(params: params),
  RouterName.error: (BuildContext context, {params}) =>
      ErrorPage(params: params),
  RouterName.goodsDetailsInfo: (BuildContext context, {params}) =>
      GoodsDetailsInfo(params: params),
  RouterName.amapPage: (BuildContext context) => AmapPage(),
  RouterName.searchGeocodePage: (BuildContext context) => SearchGeocodePage(),
  RouterName.searchPage: (BuildContext context, {params}) =>
      SearchPage(params: params),
  RouterName.flowLayout: (BuildContext context, {params}) => FlowLayout(),
  RouterName.speakPage: (BuildContext context, {params}) => SpeakPage(),
  RouterName.passwordPage: (BuildContext context, {params}) => PasswordPage(),
  RouterName.loginPage: (BuildContext context, {params}) => LoginPage(),
};
