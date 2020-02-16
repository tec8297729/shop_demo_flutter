import 'package:baixing/config/app_config.dart';
import 'package:baixing/pages/SplashPage/components/AdPage.dart';
import 'package:baixing/pages/SplashPage/components/WelcomePage.dart';
import 'package:baixing/routes/routerName.dart';
import 'package:baixing/utils/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jh_debug/jh_debug.dart';
import '../../utils/util.dart';
import 'package:flutter/material.dart';

/// 闪屏页。
class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Widget child;

  String debugLable;

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  _initAsync() async {
    SystemChrome.setEnabledSystemUIOverlays([]);
    await SpUtil.getInstance();
    setState(() {
      /// 是否显示引导页。
      if (SpUtil.getData<bool>("key_guide", defValue: true)) {
        SpUtil.setData("key_guide", false);
        child = WelcomePage();
      } else {
        child = AdPage();
      }
    });

    /// 调试阶段，直接跳过此组件
    if (AppConfig.notSplash) {
      Navigator.of(context).pushReplacementNamed(RouterName.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 初始化设计稿尺寸
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    // initPlatformState();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: child,
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
