import 'package:baixing/pages/Category/store/category_goodsList_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// 右侧商品列表
class RightCatgegoryGoodsList extends StatefulWidget {
  RightCatgegoryGoodsList({Key key});

  @override
  _RightCatgegoryGoodsListState createState() =>
      _RightCatgegoryGoodsListState();
}

class _RightCatgegoryGoodsListState extends State<RightCatgegoryGoodsList> {
  CategoryGoodsListStore categoryGoodsListStore; // 列表商品.stroe内

  List _goodsList = [];

  @override
  void initState() {
    super.initState();
    // 在build完后的第一帧后回调
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 此回调中，所有在build函数中实例的对象都已经完成，可以正常调用到
      categoryGoodsListStore.getGoodsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    categoryGoodsListStore = Provider.of<CategoryGoodsListStore>(context);
    _goodsList = categoryGoodsListStore.goodsList ?? [];

    // 没有内容显示空组件
    if (_goodsList.length == 0) return emptyTispWidget();
    ListView.builder(
      itemCount: _goodsList.length,
      itemBuilder: (context, index) {
        return _listGoods(index);
      },
    );
    // 撑开弹性布局
    return Expanded(
      flex: 1,
      child: Container(
        child: _easyRefresh(
          child: SliverList(
            // 构建一个动态list类，类似listView.builder
            delegate: SliverChildBuilderDelegate(
              (context, index) => _listGoods(index),
              childCount: _goodsList.length, // 渲染的数量
            ),
          ),
        ),
      ),
    );
  }

  // 空组件提示
  Widget emptyTispWidget() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Text(
          '暂无更多商品',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }

  // 上拉加载组件配置
  Widget _easyRefresh({@required Widget child}) {
    return EasyRefresh.custom(
      controller: categoryGoodsListStore.easyRefreshController,
      scrollController: categoryGoodsListStore.scrollControll, // 滚动控制器
      // 以下二参数开启后，需要通过easyRefreshController控制器来指定完成
      enableControlFinishRefresh: true, // 控制刷新完成
      enableControlFinishLoad: true, // 控制加载
      header: ClassicalHeader(
        noMoreText: '', // 不显示 没有更多 文字
        showInfo: true, // 显示当前刷新时间
        infoText: '上次刷新时间: %T',
        refreshText: '下拉加载...',
        refreshReadyText: '下拉加载刷新',
        refreshingText: '加载中...',
        refreshedText: '加载完成',
        refreshFailedText: '加载失败',
      ),
      footer: ClassicalFooter(
        // enableInfiniteLoad: true, // 加载完成后隐藏底部
        bgColor: Colors.white,
        textColor: Colors.pink,
        noMoreText: categoryGoodsListStore.noMoreText, // 不显示 没有更多 文字
        showInfo: true, // 显示当前刷新时间
        infoText: '上次刷新时间: %T',
        loadReadyText: '上拉加载...',
        loadingText: '加载中...',
        loadedText: '加载完成',
        loadFailedText: '加载失败',
      ),
      // 上拉加载
      onLoad: _goodsList.length > 3 ? categoryGoodsListStore.getListMore : null,
      // 下拉加载
      onRefresh: categoryGoodsListStore.refreshGoodsList,
      slivers: <Widget>[child],
    );
  }

  // 左侧商品图片
  Widget _goodsImg(int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Hero(
        tag: '${_goodsList[index]['goodsId']}',
        child: Image.network(_goodsList[index]['image']),
      ),
    );
  }

  // 右侧组件
  Widget _listGoods(int index) {
    return GestureDetector(
      // 商品点击事件
      onTap: () {
        // print('商品点击》》${_goodsList[index]['goodsId']}');
        Navigator.pushNamed(context, '/goodsDetailsInfo', arguments: {
          'goodsId': _goodsList[index]['goodsId'],
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImg(index),
            Expanded(
              child: Column(
                children: <Widget>[
                  _goodsName(index),
                  _goodsPrice(index),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 右侧商品标题
  Widget _goodsName(int index) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      child: Text(
        _goodsList[index]['goodsName'],
        maxLines: 2, // 最多2行
        overflow: TextOverflow.ellipsis, // 超出部份...
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  // 右侧商品价格
  Widget _goodsPrice(int index) {
    Map itemData = _goodsList[index];

    return Container(
      margin: EdgeInsets.only(top: 20, left: 8),
      child: Row(
        children: <Widget>[
          _priceTextWrap(
            child: Text(
              '价格：￥${itemData['presentPrice']}',
              style: TextStyle(
                color: Colors.pink,
                fontSize: ScreenUtil().setSp(30),
              ),
            ),
          ),
          _priceTextWrap(
            child: Text(
              '￥${itemData['oriPrice']}',
              style: TextStyle(
                color: Colors.black26,
                decoration: TextDecoration.lineThrough,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // 价格文字组件外层
  Widget _priceTextWrap({Widget child}) {
    return Container(
      height: ScreenUtil().setHeight(60),
      alignment: Alignment.bottomCenter,
      child: child,
    );
  }
}
