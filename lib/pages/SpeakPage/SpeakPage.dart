import 'package:flutter/material.dart';

import 'components/AnimatedMic.dart';

/// 语音识别页面
class SpeakPage extends StatefulWidget {
  @override
  _SpeakPageState createState() => _SpeakPageState();
}

class _SpeakPageState extends State<SpeakPage>
    with SingleTickerProviderStateMixin {
  String tipsText = '长按说话';
  Animation<double> _animation; // 动画对象
  AnimationController controller; // 动画控制器
  String speakRes = ''; // 语音识别结果

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: controller, // 动画controller
      curve: Curves.easeIn, // 动画曲线
    )..addStatusListener((AnimationStatus aniStatus) {
        // 动画结束后
        if (aniStatus == AnimationStatus.completed) {
          controller.reverse(); // 倒放动画
        } else if (aniStatus == AnimationStatus.dismissed) {
          // 动画开始时,启动动画
          controller.forward();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// 语音开始事件
  speakStart() {
    print('start');
    controller.forward();
    setState(() {
      tipsText = '- 识别中 -';
    });
    // AsrManager.start().then((text){});
  }

  /// 语音停止事件
  speakStop() {
    controller.reset(); // 恢复动画原位置
    controller.stop(); // 停止动画,不然未停止
    // AsrManager.stop();
  }

  /// 语音取消事件
  speakCancel() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // 上下二端对齐
            children: <Widget>[
              _topItem(),
              _bottomItem(),
            ],
          ),
        ),
      ),
    );
  }

  // 顶部内容
  _topItem() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Text(
            '你可以这样说',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
        Text(
          '故宫门票\n北京一日游\n迪士尼乐园',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
        // 语音识别结果
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            speakRes, // 识别的内容
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }

  // 整体底部按钮组件
  _bottomItem() {
    // 撑开组件
    return FractionallySizedBox(
      widthFactor: 1,
      child: Stack(
        alignment: Alignment.center, // 居中
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(10),
            height: 130, // 给下部留空间,给浮动按钮ICON动画用
            child: Text(
              tipsText, // 提示文字
              style: TextStyle(color: Colors.blue, fontSize: 12),
            ),
          ),
          Positioned(
            top: 40,
            child: GestureDetector(
              // 按下
              onTapDown: (e) => speakStart(),
              // 抬起
              onTapUp: (e) => speakStop(),
              // 滑出时候
              onTapCancel: () => speakStop(),
              child: AnimatedMic(animation: _animation),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            // bottom: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.close, size: 30, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
