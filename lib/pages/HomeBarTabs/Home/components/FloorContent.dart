import 'package:baixing/routes/RouteName.dart';
import 'package:baixing/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 热门推荐下方区域，流布局区域
class FloorContent extends StatelessWidget {
  final List listData;
  FloorContent({Key key, @required this.listData});
  static BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods(),
        ],
      ),
    );
  }

  // 首组件，二栏
  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(listData[0]),
        Column(
          children: <Widget>[
            _goodsItem(listData[1]),
            _goodsItem(listData[2]),
          ],
        ),
      ],
    );
  }

  // 底部区域左右二个组件
  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _goodsItem(listData[3]),
        _goodsItem(listData[4]),
      ],
    );
  }

  // 显示的组件
  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: GestureDetector(
        // 商品点击事件
        onTap: () {
          Navigator.pushNamed(_context, RouteName.goodsDetailsInfo, arguments: {
            'goodsId': goods['goodsId'],
          });
        },
        child: ImageUtils.getNetWorkImageWidget(goods['image']),
      ),
    );
  }
}
