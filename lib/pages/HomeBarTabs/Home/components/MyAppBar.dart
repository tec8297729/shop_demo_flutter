import 'package:baixing/components/SearchBar/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  MyAppBar({this.appBarAlpha});

  final double appBarAlpha;
  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  // TODO: implement preferredSize
  // Size get preferredSize => Size.fromHeight(kToolbarHeight + (0.0));
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  // 跳转搜索页面
  goSearchPage() {
    Navigator.pushNamed(context, '/searchPage');
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      child: headerWidget(),
      removeBottom: true,
    );
  }

  // 顶部栏组件
  Widget headerWidget() {
    Widget searchWidget = SearchBar(
      searchBarType: widget.appBarAlpha > 0.2
          ? SearchBarType.homeLight // 大于二分之一时，高亮显示
          : SearchBarType.home,
      defaultText: '网红热门打卡 美食、景点、酒店',
      leftButtonClick: () => goSearchPage(),
      speakClick: () => goSearchPage(),
      inputBoxClick: () => goSearchPage(),
      rightButtonClick: () => goSearchPage(),
    );

    // 搜索整体组件
    Widget searWrap = Container(
      decoration: BoxDecoration(
        color: Color(0xFFD1222A),
        // 线性渐变颜色
        // gradient: LinearGradient(
        //   colors: [Color(0x66000000), Colors.transparent],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        // ),
        // 阴影
        boxShadow: widget.appBarAlpha > 0.2
            ? [BoxShadow(color: Colors.black12, blurRadius: 4.5)]
            : null,
      ),
      child: Container(
        height: ScreenUtil().setHeight(160),
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        decoration: BoxDecoration(
          // 动态改变盒子的背景色--透明度，滑动
          color:
              Color.fromARGB((widget.appBarAlpha * 255).toInt(), 255, 255, 255),
        ),
        child: searchWidget,
      ),
    );
    return searWrap;
    // 模式2：内置透明组件
    // Opacity(
    //   opacity: appBarAlpha,
    //   child: searWrap,
    // ),
  }
}
