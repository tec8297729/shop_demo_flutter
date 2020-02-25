import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 标题组件
/// [right] 右侧显示的组件
class NCTItle extends StatelessWidget {
  NCTItle({this.title, this.right});
  final String title;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 5),
          height: ScreenUtil().setHeight(70),
          child: Text(
            title,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        if (right != null)
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 5),
            height: ScreenUtil().setHeight(70),
            child: right,
          ),
      ],
    );
  }
}
