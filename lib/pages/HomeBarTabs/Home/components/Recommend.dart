import 'package:baixing/routes/routerName.dart';
import 'package:baixing/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 热门推荐栏
class Recommend extends StatelessWidget {
  final List<Map> listData;
  Recommend({Key key, @required this.listData});
  static BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Container(
      width: double.infinity,
      // height: ScreenUtil().setHeight(400),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList(),
        ],
      ),
    );
  }

  // 推荐标题栏
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: ScreenUtil().setHeight(80),
      padding: EdgeInsets.only(left: 20),
      child: Text(
        '热门推荐',
        style: TextStyle(
          color: Colors.pink,
          fontSize: ScreenUtil().setSp(32),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        // 设置指定边框
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12),
        ),
      ),
    );
  }

  // item商品组件
  Widget _goodsItemWidget(index) {
    final itemData = listData[index];
    return GestureDetector(
      // 商品点击事件
      onTap: () {
        Navigator.pushNamed(_context, RouterName.goodsDetailsInfo, arguments: {
          'goodsId': itemData['goodsId'],
        });
      },
      child: Container(
        height: ScreenUtil().setHeight(333),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            right: (index != listData.length)
                ? BorderSide(width: 0.5, color: Colors.black12)
                : null,
          ),
        ),
        child: Column(
          children: <Widget>[
            ImageUtils.getNetWorkImageWidget(itemData['image']),
            Text('￥${itemData['mallPrice']}'),
            Text(
              '￥${itemData['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 商品列表
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(360),
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // 列表滚动方向，horizontal横向
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) {
          return _goodsItemWidget(index);
        },
      ),
    );
  }
}
