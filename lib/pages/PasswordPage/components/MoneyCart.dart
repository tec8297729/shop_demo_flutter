import 'package:baixing/components/NumAnimation/NumAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

/// 金额卡片组件
class MoneyCart extends StatefulWidget {
  @override
  _MoneyCartState createState() => _MoneyCartState();
}

class _MoneyCartState extends State<MoneyCart>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<num> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this, // 只有with继承了指定的组件才有this属性
    );
    animation = Tween(begin: 0, end: 360.0).animate(controller);
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
    print(animation.value);
    return AnimatedBuilder(
      animation: animation, // 定义动画效果
      child: GestureDetector(
        onTap: () {
          controller.forward(from: 0);
        },
        child: _contextPage(),
      ),
      builder: (BuildContext context, Widget child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0001)
            ..rotateY(math.pi * animation.value / 180), //
          alignment: FractionalOffset.center, // 对齐方式
          child: child,
        );
      },
    );
  }

  /// 内容
  Widget _contextPage() {
    return Container(
      margin: EdgeInsets.all(13),
      width: double.infinity,
      height: ScreenUtil().setHeight(370),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('asset/images/moneyBg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 18, 0, 10),
            child: Column(
              children: <Widget>[
                currentAmount('当前余额(元)', 132.33),
                cumulativeWidget(),
              ],
            ),
          ),
          _positionTag(),
        ],
      ),
    );
  }

  /// 当前金额组件
  Widget currentAmount(String title, double money, {TextStyle moneyStyle}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _textWidget(title),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 6),
          child: NumAnimation(
            value: money,
            style: moneyStyle != null
                ? moneyStyle
                : TextStyle(
                    fontSize: ScreenUtil().setSp(58),
                    color: Colors.white,
                  ),
          ),
        ),
      ],
    );
  }

  /// 累计金额组件
  Widget cumulativeWidget() {
    TextStyle _textStyle = TextStyle(
      fontSize: ScreenUtil().setSp(35),
      color: Colors.white,
    );
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 120),
            child: currentAmount('累计结算金额', 3200.00, moneyStyle: _textStyle),
          ),
          currentAmount('累计发放补贴', 132.33, moneyStyle: _textStyle),
        ],
      ),
    );
  }

  Widget _textWidget(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
          color: Color(0xFFD4E2FA),
        ),
      ),
    );
  }

  /// 右上角浮tag
  Widget _positionTag() {
    return Positioned(
      right: -40,
      top: 20,
      child: Transform.rotate(
        angle: math.pi * 45 / 180, // 获取tween动态开始到结束的值，在计算一次
        child: Container(
          alignment: Alignment.center,
          width: ScreenUtil().setWidth(240),
          height: ScreenUtil().setHeight(46),
          color: Colors.red.withOpacity(0.6),
          child: Text(
            '最新',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
