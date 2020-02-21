import 'package:baixing/components/NumAnimation/NumAnimation.dart';
import 'package:baixing/pages/AccountPage/provider/accountPage.p.dart';
import 'package:baixing/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_animations/simple_animations.dart';

/// 顶部头像区域组件
class TopHeader extends StatefulWidget {
  @override
  _TopHeaderState createState() => _TopHeaderState();
}

class _TopHeaderState extends State<TopHeader> {
  final tween = MultiTrackTween([
    Track("color1").add(
      Duration(seconds: 3),
      ColorTween(
        begin: Colors.lightBlue.withOpacity(0.3),
        end: Colors.lightBlue.shade900,
      ),
    ),
    Track("color2").add(
      Duration(seconds: 3),
      ColorTween(
        begin: Colors.purple.withOpacity(0.3),
        end: Colors.blue.shade600,
      ),
    ),
    Track("color3").add(
      Duration(seconds: 3),
      ColorTween(
        begin: Color(0xFFEFD98D).withOpacity(0.3),
        end: Colors.blue.shade600,
      ),
    ),
    Track("color4").add(
      Duration(seconds: 3),
      ColorTween(
        begin: Color(0xFF9F44D3).withOpacity(.5),
        end: Colors.blue.shade600,
      ),
    ),
  ]);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
      playback: Playback.MIRROR, // 动画模式效果
      tween: tween, // 动画值
      duration: tween.duration, // 持续时间
      builder: (context, animation) {
        return Container(
          height: ScreenUtil().setHeight(400),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                animation["color1"],
                animation["color2"],
                animation["color3"],
                animation["color4"],
              ],
              stops: [0.2, 0.4, 0.6, 1],
              transform: GradientRotation(111),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _avaWidget(), // 头像
              _avaTitle(), // 文字区域
            ],
          ),
        );
      },
    );
  }

  /// 头像组件
  Widget _avaWidget() {
    return Consumer<AccountPageStore>(
      builder: (_, store, __) {
        return Container(
          width: 100,
          height: 100,
          child: CircleAvatar(
            foregroundColor: Colors.cyan,
            radius: 30, // 圆的直径
            backgroundColor: Colors.transparent, // 背景颜色
            backgroundImage: store.avatarImg == null
                ? ImageUtils.getNetWorkImage(
                    'https://i.keaitupian.net/up/fe/98/d9/884ada56623a11f6a0f38ab29fd998fe.jpg')
                : FileImage(store.avatarImg),
          ),
        );
      },
    );
  }

  /// 文字组件
  Widget _avaTitle() {
    return Shimmer.fromColors(
      baseColor: Colors.black, // 背景底色
      highlightColor: Colors.white, // 高亮颜色
      period: Duration(milliseconds: 5000), // 动画时间
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20, right: 5),
            child: Text(
              '未知的小强',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color: Colors.black,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 22),
            child: NumAnimation(value: 1000),
          ),
        ],
      ),
    );
  }
}
