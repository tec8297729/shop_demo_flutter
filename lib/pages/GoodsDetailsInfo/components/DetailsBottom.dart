import 'package:baixing/routes/RouteName.dart';
import '../../HomeBarTabs/HomeBarTabs.dart';
import '../../HomeBarTabs/provider/homeBarTabsStore.p.dart';
import '../../../components/RoutsAnimation/RoutsAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../provider/goodsDetailsInfo_stroe.dart';
import '../../HomeBarTabs/Cart/provider/cartStore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          cartWidget(context),
          addCartWidget(),
          buyShopWidget(context),
        ],
      ),
    );
  }

  // 左侧 购物车图标
  Widget cartWidget(BuildContext context) {
    // 首页切换tabs控制器
    PageController homeTabsController =
        Provider.of<HomeBarTabsStore>(context).barTabsController;
    return Stack(
      overflow: Overflow.visible, // 超出范围是否剪裁，visible溢出范围显示，默认不显示
      children: <Widget>[
        GestureDetector(
          onTap: () {
            // 跳转路由缓存
            Navigator.popUntil(context, ModalRoute.withName(RouteName.home));
            homeTabsController.jumpToPage(2);
          },
          child: Container(
            width: ScreenUtil().setWidth(110),
            alignment: Alignment.center,
            child: Icon(
              Icons.shopping_cart,
              size: 35,
              color: Colors.red,
            ),
          ),
        ),
        Consumer2<GoodsDetailsInfoStore, CartStore>(
          builder: (_, goodsStore, cartStore, child) {
            // 当前商品没有数量时，不显示浮动数值组件
            if (cartStore.goodsSum == 0) return Container();
            return Positioned(
              top: -12,
              right: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  border: Border.all(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  // 商品数量
                  '${cartStore.goodsSum > 99 ? "99+" : cartStore.goodsSum}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(22),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // 加入购物车
  Widget addCartWidget() {
    return Consumer2<GoodsDetailsInfoStore, CartStore>(
      builder: (_, goodsStore, cartStore, child) {
        return GestureDetector(
          onTap: () {
            // 存当前商品数据
            cartStore.save(goodsStore.goodsInfo, count: 1);

            Fluttertoast.showToast(
              msg: '已添加至购物车',
              toastLength: Toast.LENGTH_SHORT, // 提示大小，short短提示
              gravity: ToastGravity.CENTER, // 提示位置，CENTER居中
              textColor: Colors.white, // 文字颜色
              backgroundColor: Colors.black87,
              fontSize: 22, // 提示文字大小
            );
          },
          child: Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(320),
            height: ScreenUtil().setHeight(80),
            color: Colors.green,
            child: Text(
              '加入购物车',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(28),
              ),
            ),
          ),
        );
      },
    );
  }

  // 立即购买按钮组件
  Widget buyShopWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          RoutsAnimation(
            child: HomeBarTabs(params: {'pageId': 2}),
            settings: RouteSettings(name: RouteName.home),
          ),
          (Route<dynamic> route) => false,
        );
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(320),
        height: ScreenUtil().setHeight(80),
        color: Colors.red,
        child: Text(
          '立即购买',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }
}
