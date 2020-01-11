import 'dart:async';
import 'package:flutter/material.dart';

/// debug调试按钮，指定方式按下才会触发，操作方式：快速双击二次，然后按住按钮 下移2的距离（重力加速度），上移6的距离（重力加速度）。
///
/// 注意：请在3秒内完成所有操作
class DebugBtn extends StatefulWidget {
  DebugBtn({@required this.child, @required this.success});

  /// 渲染的组件
  final Widget child;

  /// 成功后的回调，
  final VoidCallback success;
  @override
  _DebugBtnState createState() => _DebugBtnState();
}

class _DebugBtnState extends State<DebugBtn> {
  Map<String, bool> debugFlag = {
    'onDoubleTap': false, // 双击
    'onVerticalTop': false, // 上移
    'onVerticalBottom': false, // 下移
  };
  Timer _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.child,
      onTapDown: onTapDown, // 轻触手势接触了屏幕
      // 双击
      onDoubleTap: () {
        debugFlag['onDoubleTap'] = true;
      },

      onVerticalDragUpdate: onVerticalDragUpdate,
    );
  }

  // 轻触手势
  onTapDown(e) {
    print('在特定位置轻触手势接触了屏幕');
    _timer?.cancel();
    const oneSec = Duration(seconds: 3); // 定义5秒
    _timer = Timer(oneSec, () {
      bool flag = debugFlag.values.every((flag) => flag);
      print(flag);
      if (flag) {
        // 手势正确
        // jhDebug.showLog();
        widget.success();
      }
      // 重置状态
      debugFlag = {
        'onDoubleTap': false,
        'onVerticalTop': false,
        'onVerticalBottom': false,
      };
    });
  }

  // 垂直拖动
  onVerticalDragUpdate(e) {
    print(debugFlag.toString());
    if (debugFlag['onVerticalTop'] && debugFlag['onVerticalBottom']) return;
    double yNum = e.delta.dy;

    if (yNum > 1.5 && yNum < 2.5) {
      // 下移指定范围
      debugFlag['onVerticalBottom'] = true;
    } else if (yNum > -6 && yNum < -3.2) {
      // 上移指定范围
      debugFlag['onVerticalTop'] = true;
    }
  }
}
