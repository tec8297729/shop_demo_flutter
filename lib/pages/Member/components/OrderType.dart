import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 横向菜单列表
class OrderType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.only(top: 10),
      height: ScreenUtil().setHeight(150),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          orderTypeItem('待付款', Icons.query_builder),
          orderTypeItem('待发货', Icons.party_mode),
          orderTypeItem('待收货', Icons.directions_car),
          orderTypeItem('待评价', Icons.content_paste),
        ],
      ),
    );
  }

  // 横向列表item栏
  Widget orderTypeItem(String text, IconData iconData) {
    return Container(
      width: ScreenUtil().setWidth(187),
      child: Column(
        children: <Widget>[
          Icon(
            iconData,
            size: 30,
          ),
          Text(text),
        ],
      ),
    );
  }
}
