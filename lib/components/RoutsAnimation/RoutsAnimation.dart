import 'package:flutter/cupertino.dart';

/// 带跳转动画效果的路由组件
/// ```dart
/// Navigator.of(context).push(
///   RoutsAnimation(
///     child: BarTabs(
///       params: {'pageId': 1},
///     ),
///   ),
/// );
///```
class RoutsAnimation extends PageRoute {
  RoutsAnimation({
    @required this.child, // 第一个自定义参数，其它的是PageRute必带参数
    this.transitionDuration = const Duration(milliseconds: 600),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
    @required this.settings,
  });

  /// 页面跳转显示的组件
  final Widget child;

  @override
  final Duration transitionDuration; // 页面跳转持续动画时间

  @override
  final bool opaque; // 过渡完成后，路由是否会遮盖先前的路由

  @override
  final bool barrierDismissible; // 是否可以通过点击模式障碍来消除此路线

  @override
  final Color barrierColor; // 用于模式障碍的颜色。如果为null，则障碍将是透明的

  @override
  final String barrierLabel; // 障碍的语义标签，用于指定获取障碍目标

  @override
  final bool maintainState; // 路由处于非活动状态时是否应保留在内存中

  @override
  final RouteSettings settings;

  // 最终页面显示的组件
  @override
  Widget buildPage(context, animation, secondaryAnimation) {
    return child;
  }

  // 页面跳转过渡中显示的组件
  @override
  Widget buildTransitions(context, animation, secondaryAnimation, _child) {
    // 缩放的动画效果
    return ScaleTransition(
      // 动画效果0缩放从0到1，1为不缩放完整显示
      scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.fastOutSlowIn, // 曲线，快出慢进
      )),
      child: _child,
    );
  }
}
