import 'dart:async';
import 'package:baixing/routes/routerName.dart';
import 'package:baixing/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// APP入口全屏广告页面
class AdPage extends StatefulWidget {
  @override
  _AdPageState createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {
  String _info = '';
  Timer _timer;
  int timeCount;
  String adPageKey = 'adPageKey';
  VideoPlayerController _videoPlayerController; // 视频控制器
  DateTime newTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    timeCount = 5; // 倒计时总时间
    _initSplash();

    WidgetsBinding.instance.addPostFrameCallback((v) {
      String oldTimeStr = SpUtil.getData<String>(
        adPageKey,
        defValue: newTime.add(Duration(seconds: -10)).toString(),
      );
      Duration diffTime = newTime.difference(DateTime.parse(oldTimeStr));

      // 一小时内广告页面只触发一次
      if (diffTime.inSeconds < (3600)) {
        SpUtil.setData(adPageKey, newTime.toString()); // 更新缓存
        _pushHome();
        return;
      }
      setState(() {
        _videoPlayerController?.play(); // 播放
      });
    });
  }

  @override
  void dispose() {
    LogUtil.d('销毁ad');
    _videoPlayerController?.dispose();
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  /// 处理广告业务
  void handleAd() async {
    // 读取视频地址
    _videoPlayerController = VideoPlayerController.asset('asset/ad/9900.mp4');
    _videoPlayerController.setVolume(0);
    // 进入视频初始化，
    await _videoPlayerController.initialize();
  }

  /// App广告页逻辑。
  void _initSplash() async {
    const timeDur = Duration(seconds: 1); // 1秒
    handleAd();

    _timer = Timer.periodic(timeDur, (Timer t) {
      if (timeCount <= 0) {
        _pushHome();
        return;
      }
      setState(() {
        timeCount--;
        _info = "广告页，$timeCount 秒后跳转到主页";
      });
    });
  }

  /// 跳转首页
  _pushHome() {
    Navigator.of(context).pushReplacementNamed(RouterName.home);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        // Center(
        //   child: Text("$_info"),
        // ),
        _adViode(),
        flotSkipWidget(),
      ],
    );
  }

  /// 广告内容组件
  Widget _adViode() {
    return GestureDetector(
      onTap: () {
        _pushHome();
        // H5广告页面
        Navigator.pushNamed(context, RouterName.adH5View, arguments: {
          'url':
              'https://pro.m.jd.com/mall/active/3WdVHR8UbbjrYC6FCzjahQXT5SfG/index.html'
        });
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: VideoPlayer(_videoPlayerController),
      ),
    );
  }

  /// 右上角跳过组件
  flotSkipWidget() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 20,
      right: 20,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacementNamed(RouterName.home);
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0, 2.0),
                blurRadius: 2.0,
              ),
            ],
          ),
          child: Text(
            '$timeCount  |  跳过',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
