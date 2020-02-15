import 'package:baixing/routes/routerName.dart';
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
          orderTypeItem('个人资料', Icons.person_pin, onTap: () {
            Navigator.of(context).pushNamed(RouterName.accountPage);
          }),
          orderTypeItem('待发货', Icons.party_mode),
          orderTypeItem('待收货', Icons.directions_car),
          orderTypeItem('提现管理', Icons.monetization_on, onTap: () {
            Navigator.of(context).pushNamed(RouterName.passwordPage);
          }),
        ],
      ),
    );
  }

  // 横向列表item栏
  Widget orderTypeItem(String text, IconData iconData, {Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ScreenUtil().setWidth(187),
        child: Column(
          children: <Widget>[
            Icon(iconData, size: 30),
            Text(text),
          ],
        ),
      ),
    );
  }
}
