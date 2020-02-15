import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountListItem extends StatelessWidget {
  AccountListItem({this.title, this.trailing, this.height, this.onTap});
  final String title;
  final Widget trailing;
  final double height;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: ScreenUtil().setHeight(height ?? 130),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: ListTile(
        // 右侧组件
        trailing: Container(
          alignment: Alignment.centerRight,
          constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              if (trailing != null) trailing,
              Icon(Icons.arrow_right),
            ],
          ),
        ),
        title: Text(title), // 标题
        onTap: onTap,
      ),
    );
    ;
  }
}
