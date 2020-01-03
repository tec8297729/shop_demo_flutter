import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../model/goodsDetailsInfo_stroe.dart';

// 商品详情内容区域
class DetailsTabBar extends StatefulWidget {
  @override
  _DetailsTabBarState createState() => _DetailsTabBarState();
}

class _DetailsTabBarState extends State<DetailsTabBar> {
  GoodsDetailsInfoStore goodsDetailsStore;
  @override
  Widget build(BuildContext context) {
    goodsDetailsStore = Provider.of<GoodsDetailsInfoStore>(context);

    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 20),
      child: Row(
        children: <Widget>[
          _myTabBarWidget(
            '详情',
            tabIndex: 0,
          ),
          _myTabBarWidget(
            '评论',
            tabIndex: 1,
          ),
        ],
      ),
    );
  }

  // 自定义一个tabs
  Widget _myTabBarWidget(String text, {int tabIndex}) {
    return Consumer<GoodsDetailsInfoStore>(
      builder: (_, GoodsDetailsInfoStore store, child) {
        return GestureDetector(
          onTap: () {
            store.changeTabs(tabIndex); // 存当前点击索引
          },
          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(375),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                // 底边框
                bottom: BorderSide(
                  width: 1,
                  color: store.selectTab == tabIndex
                      ? Colors.pink
                      : Colors.transparent,
                ),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: store.selectTab == tabIndex ? Colors.pink : Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
