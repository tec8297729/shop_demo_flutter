import 'package:provider/provider.dart';

// 局部状态
import 'pages/HomeBarTabs/provider/homeBarTabsStore.p.dart';
import 'pages/Category/provider/category_store.dart';
import 'pages/Category/provider/category_goodsList_store.dart';
import 'pages/GoodsDetailsInfo/provider/goodsDetailsInfo_stroe.dart';
import 'pages/Cart/provider/cartStore.dart';
import 'provider/themeStore.dart';

// 状态管理配置
List<SingleChildCloneableWidget> providersConfig = [
  ChangeNotifierProvider<ThemeStore>.value(value: ThemeStore()), // 主题颜色
  // 首页bartabs
  ChangeNotifierProvider<HomeBarTabsStore>.value(value: HomeBarTabsStore()),
  // category页 右顶部数据
  ChangeNotifierProvider<CategoryStore>.value(value: CategoryStore()),
  // category页 分类列表
  ChangeNotifierProvider<CategoryGoodsListStore>.value(
      value: CategoryGoodsListStore()),
  ChangeNotifierProvider<GoodsDetailsInfoStore>.value(
      value: GoodsDetailsInfoStore()),
  // 商品数据
  ChangeNotifierProvider<CartStore>.value(value: CartStore()),
];
