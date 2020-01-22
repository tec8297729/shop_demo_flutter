import 'package:baixing/components/FadeInImageNetwork/FadeInImageNetwork.dart';
import 'package:baixing/pages/HomeBarTabs/provider/homeBarTabsStore.p.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import '../../Category/provider/category_store.dart';

// 轮播图下方nav图标区域
class TopNavigator extends StatelessWidget {
  TopNavigator({Key key, @required this.navigatorList}) : super(key: key);
  final List navigatorList;
  static CategoryStore _categoryStore;
  static HomeBarTabsStore _barTabsStore;

  @override
  Widget build(BuildContext context) {
    _categoryStore = Provider.of<CategoryStore>(context);
    _barTabsStore = Provider.of<HomeBarTabsStore>(context);
    // 超出指定数量，只截取部份数据
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(320),
      child: Swiper(
        outer: false,
        itemCount: 1,
        itemBuilder: (context, index) {
          return GridView.count(
            crossAxisCount: 5, // 每行五个
            padding: EdgeInsets.all(5),
            children: navigatorList.map((item) {
              return _gridViewItemUi(context, item);
            }).toList(),
            physics: NeverScrollableScrollPhysics(), // 禁止滚动
          );
        },
        // pagination: SwiperCustomPagination(
        //   builder: (BuildContext context, SwiperPluginConfig config) {
        //     // 自定义分页器功能，config可以获取到所有配置信息
        //     print(config.itemCount); // 10总数量
        //     return Text('data'); // TODO: 循环实现多个分页图标
        //   },
        // ),
      ),
    );
  }

  // 每个icon组件
  Widget _gridViewItemUi(BuildContext context, item) {
    return GestureDetector(
      // 图标点击事件
      onTap: () {
        print(item['mallCategoryId']);
        _categoryStore.setLeftSelect(item); // 存选中左侧菜单
        _barTabsStore.getBarTabsCont.jumpToPage(1);
      },
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(95),
            child: Image(
              image: AdvancedNetworkImage(
                '${item['image']}',
                useDiskCache: true,
                cacheRule: CacheRule(maxAge: const Duration(days: 30)),
                fallbackImage: FadeInImageNetwork.kTransparentImage,
              ),
            ),
            //  CachedNetworkImage(
            //   imageUrl: '${item['image']}',
            //   // 图片读取失败显示的weiget组件
            //   errorWidget: (context, url, error) => new Icon(Icons.error),
            // ),
          ),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }
}
