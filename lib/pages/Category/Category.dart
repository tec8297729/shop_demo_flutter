import '../../pages/Category/components/LeftCatgegoryNav.dart';
import '../../pages/Category/components/RightCatgegoryGoodsList.dart';
import '../../pages/Category/components/RightCatgegoryNav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/category_goodsList_store.dart';

class Category extends StatefulWidget {
  Category({Key key, this.params}) : super(key: key);
  final params;

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  CategoryGoodsListStore categoryGoodsListStore;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    categoryGoodsListStore = Provider.of<CategoryGoodsListStore>(context);
    categoryGoodsListStore.setContext = context; // 执行上下文存入状态管理
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类Category'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCatgegoryNav(),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  RightCatgegoryNav(),
                  RightCatgegoryGoodsList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
