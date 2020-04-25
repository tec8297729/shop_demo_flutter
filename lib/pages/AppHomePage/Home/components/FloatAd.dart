import 'package:baixing/pages/AppHomePage/Home/provider/homeStroe.p.dart';
import 'package:baixing/routes/routeName.dart';
import 'package:baixing/utils/image_utils.dart';
import 'package:baixing/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 全局浮动ad广告
class FloatAd extends StatefulWidget {
  @override
  _FloatAdState createState() => _FloatAdState();
}

class _FloatAdState extends State<FloatAd> with SingleTickerProviderStateMixin {
  HomeStore homeStore;
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: -60).animate(controller);

    WidgetsBinding.instance.addPostFrameCallback((v) {
      homeStore.homeScrollControll?.addListener(homeListener);
    });
  }

  @override
  void dispose() {
    homeStore.homeScrollControll.removeListener(homeListener);
    controller.dispose();
    super.dispose();
  }

  /// 滚动监听
  homeListener() {
    controller.forward();
    Util.debounce(resetRight, 2000)();
  }

  resetRight(data) {
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    homeStore = Provider.of<HomeStore>(context);

    return AnimatedBuilder(
      animation: animation,
      child: _adContainer(),
      builder: (BuildContext context, Widget child) {
        return Positioned(
          right: animation.value,
          bottom: 50,
          child: child,
        );
      },
    );
  }

  Widget _adContainer() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteName.activityPage);
      },
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(2.0, 12.0), // 阴影位置,指定阴影往某个方向
              blurRadius: 4.0, // 阴影模糊度
              spreadRadius: -12.0, // 阴影模糊大小，阴影外边距,指定区域不会有阴影
            )
          ],
          image: DecorationImage(
            image: ImageUtils.getAssetImage('asset/ad/panel_ab5992d.gif'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
