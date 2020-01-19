import 'dart:io';
import 'package:baixing/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ota_update/ota_update.dart';
import 'package:url_launcher/url_launcher.dart';

/// 更新APP组件
class UpdateAppVersion extends StatefulWidget {
  UpdateAppVersion({
    this.version = 'v1.0.0',
    this.children,
  });

  /// APP版本号
  final String version;

  /// 更新内容介绍
  final List<String> children;

  @override
  _UpdateAppVersionState createState() => _UpdateAppVersionState();
}

class _UpdateAppVersionState extends State<UpdateAppVersion> {
  final double widthWrap = ScreenUtil().setWidth(550);
  bool downloadFlag = true; // 是否正在下载
  double downAppProgress = 0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('object');
  }

  // 通过此生命周期获取APP中的一些其它生命周期
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state.toString());
    if (state == AppLifecycleState.resumed) {
      print('可见并能响应用户的输入');
    }
  }

  @override
  void dispose() {
    print('隐藏');
    super.dispose();
  }

  /// APP版本更新
  void _updateVersion() async {
    if (Platform.isIOS) {
      // IOS应用更新地址，演示为微信的地址
      String url = 'itms-apps://itunes.apple.com/cn/app/id414478124?mt=8';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else if (Platform.isAndroid) {
      String url =
          'https://qn.yingyonghui.com/apk/6595333/64fa283dd09537f1cf5636f8ebffc844?sign=9b462755d225f60463c922567dcedd4e&t=5e23329b&attname=64fa283dd09537f1cf5636f8ebffc844.apk';
      try {
        OtaUpdate()
            .execute(url, destinationFilename: 'flutter_hello_world.apk')
            .listen(
          (OtaEvent event) {
            print('status:${event.status},value:${event.value}');
            switch (event.status) {
              case OtaStatus.DOWNLOADING: // 下载中
                setState(() {
                  downAppProgress = double.parse(event.value);
                });
                break;
              case OtaStatus.INSTALLING: //安装中
                Navigator.pop(context);
                break;
              case OtaStatus.PERMISSION_NOT_GRANTED_ERROR: // 权限错误
                Util.toastTips('更新失败，请稍后再试');
                Util.storagePerm(); // 权限申请
                break;
              default:
            }
          },
        );
      } catch (e) {
        print('更新失败，请稍后再试');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthWrap,
      height: ScreenUtil().setHeight(740),
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          headerW(), // 头部
          contentArea(),
          bottomW(),
        ],
      ),
    );
  }

  /// 头部组件
  Widget headerW() {
    final String headerImg = 'asset/images/updateVersion/header/up_header.png';
    final Color strColor = Colors.white;
    final double boxHeight = ScreenUtil().setHeight(293);

    return Container(
      width: double.infinity,
      height: boxHeight,
      child: Stack(
        children: <Widget>[
          // 背景图
          Image(
            // width: ScreenUtil().setWidth(583),
            width: double.infinity,
            height: boxHeight,
            image: AssetImage(headerImg),
            fit: BoxFit.fill,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 左对齐
              children: <Widget>[
                Text(
                  '发现新版本',
                  style: TextStyle(
                    color: strColor,
                    fontSize: ScreenUtil().setSp(40),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 3, top: 6),
                  child: Text(
                    widget.version ?? '', // 最新版本号
                    style: TextStyle(
                      color: strColor,
                      fontSize: ScreenUtil().setSp(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 底部组件
  Widget bottomW() {
    Widget _child = Container(
      width: ScreenUtil().setWidth(360),
      height: ScreenUtil().setHeight(76),
      child: RaisedButton(
        child: Text(
          '立即升级',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 2,
            fontSize: ScreenUtil().setSp(34),
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 4,
        color: Color(0xff009FF9),
        onPressed: () {
          // 升级操作
          _updateVersion();
          setState(() {
            downloadFlag = true;
          });
        },
      ),
    );

    if (downloadFlag) {
      // 下载中，进度条
      _child = Container(
        // margin: EdgeInsets.only(top: 15),
        width: ScreenUtil().setWidth(360),
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(40),
                child: LinearProgressIndicator(
                  value: downAppProgress / 100, // 加载进度
                  valueColor: AlwaysStoppedAnimation(Color(0xff009FF9)),
                  // backgroundColor: Colors.yellowAccent,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 2),
                child: Text(
                  downAppProgress > 0 ? '下载进度:$downAppProgress%' : '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(22),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(140),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[_child],
      ),
    );
  }

  /// 内容区
  Widget contentArea() {
    int len = widget?.children?.length ?? 10;
    return Container(
      height: ScreenUtil().setHeight(300),
      // margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          for (var i = 0; i < len; i++)
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                // '${i + 1}、${widget?.children[i]}',
                '${i + 1}、这是更新内容这是更新内容这是更新内容这是更新内容。',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                ),
              ),
            ),
          // ...widget.children ?? [],
        ],
      ),
    );
  }
}
