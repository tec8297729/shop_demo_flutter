import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 自定义AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    this.backgroundColor,
    this.title: '',
    this.centerTitle: true,
    this.actionName: '',
    this.onPressed,
    this.isBack: true,
    this.rightWidget,
    this.elevation: 4,
    this.backTips,
    this.textStyle,
  });

  /// 背景颜色
  final Color backgroundColor;

  /// 标题
  final String title;

  /// 标题是否居中
  final bool centerTitle;

  /// 标题文字样式
  final TextStyle textStyle;

  /// 右侧标题内容
  final String actionName;

  /// 右侧点击事件
  final VoidCallback onPressed;

  /// 右侧自定义显示组件
  final Widget rightWidget;

  /// 是否显示左侧回退按钮
  final bool isBack;

  /// 长按提示内容
  final String backTips;

  /// 阴影
  final double elevation;

  // 整体AppBar高度
  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;

    if (backgroundColor == null) {
      _backgroundColor = Theme.of(context).primaryColor;
    } else {
      _backgroundColor = backgroundColor;
    }

    // 判断主题色变更
    SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(_backgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;

    return Semantics(
      label: '自定义AppBar组件',
      namesRoute: true,
      header: true,
      // 修改状态栏颜色
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: _overlayStyle,
        child: Material(
          color: _backgroundColor,
          elevation: elevation,
          child: SafeArea(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                titleWidget(context),
                leftW(context),
                rightW(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 标题内容
  Widget titleWidget(BuildContext context) {
    return Container(
      alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
      width: double.infinity,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Theme.of(context).primaryIconTheme.color,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 48.0),
    );
  }

  /// 左侧组件
  Widget leftW(BuildContext context) {
    return IconButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        Navigator.maybePop(context);
      },
      tooltip: backTips,
      padding: const EdgeInsets.all(12.0),
      icon: Icon(
        Icons.arrow_back,
        color: Theme.of(context).primaryIconTheme.color,
      ),
    );
  }

  /// 右侧组件
  Widget rightW(BuildContext context) {
    Widget _child = Theme(
      data: Theme.of(context).copyWith(
        buttonTheme: ButtonThemeData(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          minWidth: 60.0,
        ),
      ),
      child: actionName.isEmpty
          ? Container()
          : FlatButton(
              child: Text(actionName, key: const Key('actionName')),
              highlightColor: Colors.transparent,
              onPressed: onPressed,
            ),
    );
    // 显示自定义右侧组件
    if (rightWidget != null) {
      _child = rightWidget;
    }

    return Positioned(
      right: 0.0,
      child: _child,
    );
  }
}
