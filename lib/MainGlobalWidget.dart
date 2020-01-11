import 'package:flutter/material.dart';

class MainGlobalWidget extends StatelessWidget {
  MainGlobalWidget({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.forward), // 设置按钮icon图标
          backgroundColor: Colors.pink, // 按钮的背景颜色
          mini: false, // 是否是小图标
          elevation: 10, // 未点击时的阴影值
          highlightElevation: 20, // 点击状态时的阴影值
        )
      ],
    );
  }
}
