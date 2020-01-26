import 'package:flutter/material.dart';

class AnimatedMic extends AnimatedWidget {
  static final double MIC_SIZE = 80;
  static final _opacityTween = Tween(begin: 1, end: 0.5); // 动画区间值
  // 组件大小变化区间值
  static final _sizeTween = Tween<double>(begin: MIC_SIZE, end: MIC_SIZE - 20);
  AnimatedMic({Key key, Animation animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> _animation = listenable; // 动画监听animation
    double _opacity = _opacityTween.evaluate(_animation).toDouble();
    double _boxAni = _sizeTween.evaluate(_animation).toDouble();

    return AnimatedBuilder(
      animation: _animation, // 定义动画效果
      child: Container(
        alignment: Alignment.center,
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(_opacity),
          borderRadius: BorderRadius.circular(MIC_SIZE / 2), // 圆
        ),
        child: Icon(
          Icons.mic,
          color: Colors.white,
          size: 30,
        ),
      ),
      builder: (BuildContext context, Widget child) {
        return ScaleTransition(
          alignment: Alignment.center, // 指定缩放中心点
          scale: Tween(begin: 1.0, end: 0.7).animate(_animation),
          child: child, // 你要显示的组件
        );
      },
    );
  }
}
