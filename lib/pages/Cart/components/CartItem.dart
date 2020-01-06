import 'package:baixing/pages/Cart/store/cartStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import './GoodsCount.dart'; // 数量控制组件

// 商品卡片
class CartItem extends StatelessWidget {
  CartItem(this.itemData, this.itemIdx);
  final itemData;
  final int itemIdx;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
      ),
      child: Consumer<CartStore>(
        builder: (_, cartStore, child) {
          return Row(
            children: <Widget>[
              cartCheckBtn(cartStore), // 勾选
              cartImage(context), // 图片
              cartGoodsName(context), // 标题名称区域
              cartPrice(cartStore), // 右侧价格区域
            ],
          );
        },
      ),
    );
  }

  // 当前商品 复选勾按钮
  Widget cartCheckBtn(cartStore) {
    return Container(
      child: Checkbox(
        value: itemData['isSelect'] ?? false,
        activeColor: Colors.pink, // 选中颜色
        onChanged: (bool val) {
          // 更新当前商品勾选状态
          cartStore.changeIsSelect(itemData, val);
        },
      ),
    );
  }

  // 商品图片
  Widget cartImage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/goodsDetailsInfo', arguments: {
          'goodsId': itemData['goodsId'],
        });
      },
      child: Container(
        width: ScreenUtil().setWidth(150),
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black12),
        ),
        child: Image.network(itemData['image1']),
      ),
    );
  }

  // 商品名称
  Widget cartGoodsName(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/goodsDetailsInfo', arguments: {
                'goodsId': itemData['goodsId'],
              });
            },
            child: Text(itemData['goodsName']),
          ),
          GoodsCount(
            itemData: itemData,
            itemIdx: itemIdx,
          ),
        ],
      ),
    );
  }

  // 商品价格,及删除按钮
  Widget cartPrice(cartStore) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end, // Y轴对齐方式
        children: <Widget>[
          Text(
            '￥${itemData['presentPrice']}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
            ),
          ),
          // 原价格
          Text(
            '原价：￥${itemData['oriPrice']}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(22),
              decoration: TextDecoration.lineThrough,
              color: Colors.black26,
            ),
            textAlign: TextAlign.right,
          ),
          Container(
            child: GestureDetector(
              // 删除按钮
              onTap: () {
                // print(object)
                cartStore.deleteOneGoods(itemData);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
