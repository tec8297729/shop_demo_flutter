import '../../Cart/provider/cartStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// 商品数量添加减少组件
class GoodsCount extends StatelessWidget {
  GoodsCount({Key key, @required this.itemIdx, @required this.itemData});
  final int itemIdx;
  final Map itemData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black12,
        ),
      ),
      child: Consumer<CartStore>(
        builder: (_, cartStore, child) {
          return Row(
            children: <Widget>[
              reduceBtn(cartStore),
              countArea(cartStore),
              addBtn(cartStore),
            ],
          );
        },
      ),
    );
  }

  // 减少按钮
  Widget reduceBtn(CartStore cartStore) {
    return btnBasis(
      text: '-',
      isAddBtn: false,
      disable: itemData['count'] == 1, // 是否禁用
      onTap: () {
        cartStore.addOrReduceGoodsCount(itemIdx);
      },
    );
  }

  // 加号按钮
  Widget addBtn(CartStore cartStore) {
    return btnBasis(
      text: '+',
      isAddBtn: true,
      onTap: () {
        cartStore.addOrReduceGoodsCount(itemIdx, type: 'add');
      },
    );
  }

  // 中间数量显示区域
  Widget countArea(CartStore cartStore) {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${itemData['count']}'),
    );
  }

  // 按钮样式封装处理
  Widget btnBasis({
    @required String text,
    @required Function onTap,
    @required bool isAddBtn,
    disable: false,
  }) {
    Border borderOpts = Border(
      right:
          isAddBtn ? BorderSide(width: 1, color: Colors.black12) : BorderSide(),
      left: !isAddBtn
          ? BorderSide(width: 1, color: Colors.black12)
          : BorderSide(),
    );
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: !disable ? Colors.white : Colors.black12,
          border: borderOpts,
        ),
        child: Text(text),
      ),
    );
  }
}
