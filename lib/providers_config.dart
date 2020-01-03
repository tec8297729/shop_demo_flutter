import 'package:provider/provider.dart';
// 全局相关
import 'model/themeStore/themeStore.dart'; // 主题颜色

// 局部状态
import 'pages/Category/model/category_store.dart';
import 'pages/Category/model/category_goodsList_store.dart';
import 'pages/GoodsDetailsInfo/model/goodsDetailsInfo_stroe.dart';
import 'pages/Cart/model/cartStore.dart';
import 'pages/BarTabs/model/barTabsStore.dart';

// 状态管理配置
List<SingleChildCloneableWidget> providersConfig = [
  ChangeNotifierProvider<ThemeStore>.value(value: ThemeStore()), // 主题颜色
  // 首页bartabs
  ChangeNotifierProvider<BarTabsStore>.value(value: BarTabsStore()),
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
