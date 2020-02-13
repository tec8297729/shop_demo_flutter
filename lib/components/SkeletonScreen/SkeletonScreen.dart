import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'components/DefualtItemSkeleton.dart';

/// 骨架块背景色
final Color _skeChildBgColor = Color(0xFFCCCCCA);

class SkeletonScreen extends StatelessWidget {
  SkeletonScreen({
    this.child,
    this.skeChild,
    this.bgColor: const Color(0xFFFAFAFA),
    @required this.isShow,
    this.defualtLen: 6,
  });

  /// 显示的内容组件
  final Widget child;

  /// 显示骨架的组件
  final List<Widget> skeChild;

  /// 骨架屏背景色
  final Color bgColor;

  /// 隐藏骨架屏, 显示具体内容组件
  final bool isShow;

  /// 默认骨架整体样式组件显示的数量
  final int defualtLen;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child ?? Container(),
        Offstage(
          child: _skeletonWidget(),
          offstage: isShow,
        ),
      ],
    );
  }

  /// 骨架组件
  Widget _skeletonWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      color: bgColor,
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _defalutSkeleton(),
        ),
      ),
    );
  }

  /// 是否加载默认骨架样式
  List<Widget> _defalutSkeleton() {
    if (skeChild != null) return skeChild;

    return [
      for (var i = 0; i < defualtLen; i++) DefualtItemSkeleton(),
    ];
  }

  /// 矩形骨架块
  static Widget skeRect({
    double width: double.infinity,
    double height: 30,
  }) {
    return Container(
      width: width,
      height: height,
      color: _skeChildBgColor,
    );
  }

  /// 方形骨架块
  static Widget skeQuare([double size = 100]) {
    return skeRect(
      height: size,
      width: size,
    );
  }

  /// 圆形骨架块
  static Widget skeCircle([double radius = 32]) {
    return CircleAvatar(
      backgroundColor: _skeChildBgColor,
      radius: radius,
    );
  }
}
