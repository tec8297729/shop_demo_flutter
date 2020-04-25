import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/nCoVPage/provider/nCoVPage.p.dart';
import 'provider/locatingStore.dart';
import 'provider/themeStore.dart';

// 局部状态
import 'pages/AccountPage/provider/accountPage.p.dart';
import 'pages/AppHomePage/Cart/provider/cartStore.dart';
import 'pages/AppHomePage/Category/provider/category_goodsList_store.dart';
import 'pages/AppHomePage/Category/provider/category_store.dart';
import 'pages/AppHomePage/Home/provider/homeStroe.p.dart';
import 'pages/AppHomePage/provider/appHomePageStore.p.dart';
import 'pages/GoodsDetailsInfo/provider/goodsDetailsInfo_stroe.dart';
import 'pages/LoginPage/provider/loginPage.p.dart';

// 状态管理配置
List<ChangeNotifierProvider> providersConfig = [
  ChangeNotifierProvider<ThemeStore>.value(value: ThemeStore()), // 主题颜色
  // 首页bartabs
  ChangeNotifierProvider<AppHomePageStore>.value(value: AppHomePageStore()),
  ChangeNotifierProvider<HomeStore>.value(value: HomeStore()),
  // category页 右顶部数据
  ChangeNotifierProvider<CategoryStore>.value(value: CategoryStore()),
  // category页 分类列表
  ChangeNotifierProvider<CategoryGoodsListStore>.value(
      value: CategoryGoodsListStore()),
  ChangeNotifierProvider<GoodsDetailsInfoStore>.value(
      value: GoodsDetailsInfoStore()),
  // 商品数据
  ChangeNotifierProvider<CartStore>.value(value: CartStore()),
  ChangeNotifierProvider<AccountPageStore>.value(value: AccountPageStore()),
  ChangeNotifierProvider<LoginPageStore>.value(value: LoginPageStore()),
  ChangeNotifierProvider<NCoVPageStore>.value(value: NCoVPageStore()),
  ChangeNotifierProvider<LocatingStore>.value(value: LocatingStore()),
];

/// 添加到全局provider状态管理中
void addProvider<T extends ChangeNotifier>({@required T value}) {
  providersConfig.add(ChangeNotifierProvider<T>.value(value: value));
}
