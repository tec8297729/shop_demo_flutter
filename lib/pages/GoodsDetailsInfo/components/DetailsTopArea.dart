import 'package:share/share.dart';

import '../../../components/FadeInImageNetwork/FadeInImageNetwork.dart';
import '../provider/goodsDetailsInfo_stroe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GoodsDetailsInfoStore>(
      builder: (_, detailsStore, child) {
        var goodsInfo = detailsStore.goodsInfo;
        if (goodsInfo != null) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo),
                _goodsName(goodsInfo['goodsName']),
                _goodsNum(goodsInfo['goodsSerialNumber']),
                _goodsPrice(goodsInfo['presentPrice'], goodsInfo['oriPrice']),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  // 外层容器
  Widget _paddingWrap({
    Widget child,
    EdgeInsets margin,
    EdgeInsets padding,
    double height,
  }) {
    return Container(
      width: double.infinity,
      margin: margin,
      height: height,
      padding: padding ?? EdgeInsets.only(left: 18),
      child: child,
    );
  }

  // 商品图片
  Widget _goodsImage(goodsInfo) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: '${goodsInfo['goodsId']}',
          child: FadeInImageNetwork(
            imageUrl: goodsInfo['image1'].toString(),
            height: ScreenUtil().setHeight(680), // 图片高度及占位高位
          ),
        ),
        Positioned(
          top: 2,
          right: 1,
          child: shareBtn(),
        ),
      ],
    );
  }

  /// 分享按钮
  Widget shareBtn() {
    return GestureDetector(
      child: Container(
        width: ScreenUtil().setWidth(80),
        height: ScreenUtil().setHeight(80),
        decoration: BoxDecoration(
          color: Colors.black12,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.share, color: Colors.white),
      ),
      onTap: () async {
        Share.share('分享：我的个人博客 https://www.jonhuu.com');
      },
    );
  }

  // 商品名称
  Widget _goodsName(name) {
    return _paddingWrap(
      child: Text(
        name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(34),
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis, // 超出隐藏
      ),
    );
  }

  // 商品编号
  Widget _goodsNum(nums) {
    return _paddingWrap(
      margin: EdgeInsets.only(top: 8),
      child: Text(
        '编号:$nums',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
          color: Colors.black54,
        ),
      ),
    );
  }

  // 商品价格
  Widget _goodsPrice(price, oldPrice) {
    return _paddingWrap(
      // margin: EdgeInsets.only(top: 8),
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          Text(
            '￥$price',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(38),
              color: Colors.red,
            ),
          ),
          _oldPriceWidget(oldPrice),
        ],
      ),
    );
  }

  // 商品旧价格
  Widget _oldPriceWidget(oldPrice) {
    return Container(
      padding: EdgeInsets.only(left: 12),
      margin: EdgeInsets.only(top: 3),
      child: Row(
        children: <Widget>[
          Text(
            '市场价:',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              '￥$oldPrice',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Colors.black45,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
