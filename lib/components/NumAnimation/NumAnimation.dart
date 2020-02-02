import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 数值带有慢慢增加的动画效果
class NumAnimation extends StatefulWidget {
  NumAnimation({
    @required this.value,
    this.style,
    this.milliseconds = 3000,
  });

  /// 会变动的动画数值
  final double value;

  /// 数值显示样式
  final TextStyle style;

  /// 动画持续时间, 默认3秒
  final int milliseconds;
  @override
  _NumAnimationState createState() => _NumAnimationState();
}

class _NumAnimationState extends State<NumAnimation>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController controller;
  String numDataStr = '0';

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: widget.milliseconds ?? 3000),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: widget.value ?? 0).animate(controller)
      ..addListener(() {
        // 监听运动的值
        this.setState(() {
          numDataStr = _animation.value.toStringAsFixed(2);
        });
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.forward();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Text(
          numDataStr,
          style: widget.style ??
              TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color: Colors.black,
              ),
        );
      },
    );
  }
}
