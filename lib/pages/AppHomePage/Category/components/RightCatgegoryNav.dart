import '../../Category/provider/category_goodsList_store.dart';
import '../../Category/provider/category_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart' show Provider, Consumer;

class RightCatgegoryNav extends StatefulWidget {
  @override
  _RightCatgegoryNavState createState() => _RightCatgegoryNavState();
}

class _RightCatgegoryNavState extends State<RightCatgegoryNav> {
  CategoryGoodsListStore categoryGoodsListStore;

  @override
  Widget build(BuildContext context) {
    categoryGoodsListStore = Provider.of<CategoryGoodsListStore>(context);
    return Consumer<CategoryStore>(
      builder: (context, categoryStore, Widget child) {
        List rigthNavChildList = categoryStore.rigthNavChildList;
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
            color: Colors.white70,
            border: Border(
              bottom: BorderSide(width: 1, color: Color(0xFFE9E9EB)), // 边框
            ),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: rigthNavChildList.length,
            itemBuilder: (context, index) {
              return _rigthItem(rigthNavChildList[index], index, categoryStore);
            },
          ),
        );
      },
    );
  }

  // 头nav每个点击item块组件
  Widget _rigthItem(Map itemData, int index, CategoryStore categoryStore) {
    return GestureDetector(
      onTap: () {
        print(itemData);
        categoryGoodsListStore.getGoodsList(
          categoryId: itemData['mallCategoryId'] ?? null,
          categorySubId: itemData['mallSubId'] ?? null,
        );

        // 保存当前点击索引
        categoryStore.setNavSelectIndex(index);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(
          itemData['mallSubName'],
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: categoryStore.navSelectIndex == index ? Colors.pink : null,
          ),
        ),
      ),
    );
  }
}
