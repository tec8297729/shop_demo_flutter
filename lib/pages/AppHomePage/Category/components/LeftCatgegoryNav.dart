import 'package:baixing/services/service_method.dart';
import '../../Category/provider/category_goodsList_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart' show Provider;
import '../provider/category_store.dart';

class LeftCatgegoryNav extends StatefulWidget {
  @override
  _LeftCatgegoryNavState createState() => _LeftCatgegoryNavState();
}

class _LeftCatgegoryNavState extends State<LeftCatgegoryNav> {
  CategoryStore categoryStore;
  CategoryGoodsListStore categoryGoodsListStore;
  List leftListData = [];

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 获取左侧菜单数据
  void _getCategory() async {
    var res = await getCategory();
    List listData = (res['data'] as List).cast<Map>();
    categoryStore.setChildCategory(listData[0]['bxMallSubDto']);
    setState(() {
      leftListData = listData;
    });

    // 隐藏骨架屏
    Future.delayed(Duration(seconds: 3), () {
      categoryStore.setSkeWidget(true);
    });

    // print('leftListData>>>$leftListData');
  }

  @override
  Widget build(BuildContext context) {
    categoryStore = Provider.of<CategoryStore>(context);
    categoryGoodsListStore = Provider.of<CategoryGoodsListStore>(context);

    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: ListView.builder(
        itemCount: leftListData?.length,
        itemBuilder: (context, index) {
          if (leftListData.length == 0) return Container();
          return _leftItemChild(index);
        },
      ),
    );
  }

  // 文字组件
  Widget _leftItemChild(int index) {
    assert(leftListData[index] != null);
    // 当前item是否选中
    bool isSelected = (categoryStore.leftSelect['mallCategoryId'] ==
        leftListData[index]['mallCategoryId']);
    return GestureDetector(
      // 左侧菜单点击事件
      onTap: () {
        print(leftListData[index]);
        if (isSelected) return;
        categoryStore.setLeftSelect(leftListData[index]); // 存当前点击的item数据

        // 左侧分类点击，获取的子分类数据
        categoryStore.setChildCategory(
          leftListData[index]['bxMallSubDto'],
        );
        // print('左侧点击值>>>${leftListData[index]}');

        // 更新右侧list列表数据
        categoryGoodsListStore.getGoodsList(
          categoryId: leftListData[index]['mallCategoryId'],
        );
        // 更新右侧nav索引, 默认第一个
        categoryStore.setNavSelectIndex(0);
      },
      child: Container(
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(100),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFF4F4F7) : Colors.white70,
          border: Border(
            bottom: BorderSide(width: 1, color: Color(0xFFE9E9EB)),
          ),
        ),
        child: Text(
          leftListData[index]['mallCategoryName'],
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }
}
