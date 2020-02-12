import '../../../../provider/themeStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/themes/themeBlueGrey.dart';
import '../../../../constants/themes/themeLightBlue.dart';
import '../../../../constants/themes/themePink.dart';
import 'package:provider/provider.dart';

class RightDrawer extends StatefulWidget {
  @override
  _RightDrawerState createState() => _RightDrawerState();
}

class _RightDrawerState extends State<RightDrawer>
    with SingleTickerProviderStateMixin {
  ThemeStore themeStore;
  bool isCollapsed = true; // 是否展开动画
  AnimationController _animationController;
  Animation<double> widgetAnimation;
  double minWidth = 75;
  double maxWidth = 240;
  double widgetWidth = 240;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    widgetAnimation =
        Tween(begin: maxWidth, end: minWidth).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeStore = Provider.of<ThemeStore>(context);

    return AnimatedBuilder(
      animation: widgetAnimation,
      builder: (_, child) {
        return Container(
          width: widgetAnimation.value,
          child: Drawer(
            child: Container(
              color: Color(0xFF272034),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '主题色',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(40),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  buttonItem('浅蓝色', themeData: themeBlueGrey),
                  buttonItem('粉色', themeData: themePink),
                  buttonItem('天空蓝', themeData: themeLightBlue),
                  iconAnimWidget(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// 动画icon组件
  iconAnimWidget() {
    return IconButton(
      padding: EdgeInsets.only(top: 100),
      icon: AnimatedIcon(
        icon: AnimatedIcons.close_menu,
        color: Colors.white,
        size: 36,
        progress: _animationController, // 使用过度动画
      ),
      onPressed: () {
        setState(() {
          isCollapsed = !isCollapsed;
          isCollapsed
              ? _animationController.reverse() // 倒放动画
              : _animationController.forward();
        });
      },
    );
  }

  /// 按钮组件
  Widget buttonItem(String text, {ThemeData themeData}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () => themeStore.setTheme(themeData),
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Icon(
              Icons.tag_faces,
              size: 36,
              color: themeData.primaryColor,
            ),
          ),
        ),
        if (widgetAnimation.value > 210)
          Container(
            width: ScreenUtil().setWidth(280),
            child: RaisedButton(
              color: themeData.primaryColor,
              // 按钮外形
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () => themeStore.setTheme(themeData),
              child: Text(
                '主题>>$text',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(34),
                  color: themeData.buttonColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
