import 'package:baixing/store/themeStore/themeStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baixing/constants/themes/themeBlueGrey.dart';
import 'package:baixing/constants/themes/themeLightBlue.dart';
import 'package:baixing/constants/themes/themePink.dart';
import 'package:provider/provider.dart';

class RightDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeStore _theme = Provider.of<ThemeStore>(context);

    return Drawer(
      child: Container(
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '全局主题色更换',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(40),
                fontWeight: FontWeight.bold,
              ),
            ),
            buttonItem(_theme, text: '浅蓝色', themeData: themeBlueGrey),
            buttonItem(_theme, text: '粉色', themeData: themePink),
            buttonItem(_theme, text: '天空蓝', themeData: themeLightBlue),
          ],
        ),
      ),
    );
  }

  // 按钮封装
  Widget buttonItem(ThemeStore themeStore, {String text, ThemeData themeData}) {
    return Container(
      width: ScreenUtil().setWidth(300),
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        color: themeData.primaryColor,
        // 按钮外形
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          '主题>>$text',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(34),
            // color: themeData.buttonColor,
          ),
        ),
        onPressed: () {
          themeStore.setTheme(themeData);
        },
      ),
    );
  }
}
