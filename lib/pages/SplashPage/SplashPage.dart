import 'dart:async';
import 'package:baixing/pages/SplashPage/components/AdPage.dart';
import 'package:baixing/pages/SplashPage/components/WelcomePage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/sp_util.dart';
import 'package:flutter/material.dart';

/// 闪屏页。
class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Widget child;

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
      SpUtil.getInstance();
      if (SpUtil.getData<bool>("key_guide")) {
        SpUtil.setData("key_guide", true);
        child = WelcomePage();
      } else {
        child = AdPage();
      }
    });
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    // 初始化设计稿尺寸
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
          ..init(context);
    return Scaffold(
      body: child,
    );
  }
}
