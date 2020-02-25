import 'package:baixing/routes/routeName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 横向菜单列表
class OrderType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: ScreenUtil().setHeight(120),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          orderTypeItem('个人资料', Icons.person_pin, onTap: () {
            Navigator.of(context).pushNamed(RouteName.accountPage);
          }),
          orderTypeItem('疫情信息', Icons.party_mode, onTap: () {
            Navigator.of(context).pushNamed(RouteName.nCoVPage);
          }),
          orderTypeItem('待收货', Icons.directions_car),
          orderTypeItem('提现管理', Icons.monetization_on, onTap: () {
            Navigator.of(context).pushNamed(RouteName.passwordPage);
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(iconData, size: 30),
            Text(text),
          ],
        ),
      ),
    );
  }
}
