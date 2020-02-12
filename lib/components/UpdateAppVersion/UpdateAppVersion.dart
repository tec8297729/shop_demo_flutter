import 'dart:io';
import 'package:baixing/utils/util.dart' show Util;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ota_update/ota_update.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/perm_utils.dart';
import 'components/UpdateHeader.dart';
import 'components/UpdateInstr.dart';

export 'getNewAppVer.dart';

/// 更新APP组件
class UpdateAppVersion extends StatefulWidget {
  UpdateAppVersion({
    this.version,
    this.info,
  });

  /// APP版本号
  final String version;

  /// 更新内容介绍
  final List<String> info;

  @override
  _UpdateAppVersionState createState() => _UpdateAppVersionState();
}

class _UpdateAppVersionState extends State<UpdateAppVersion>
     {
  final double widthWrap = ScreenUtil().setWidth(550);
  bool downloadFlag = false; // 是否正在下载
  double downAppProgress = 0;
  String appVersion; // 最新版本号
  Animation<double> animation;
  Animation<Offset> animation2;
  AnimationController animatController;

  @override
  void initState() {
    super.initState();
    appVersion = widget.version;
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// APP版本更新
  void _updateVersion() async {
    if (Platform.isIOS) {
      // TODO: IOS应用更新地址，演示为微信的地址
      String url = 'itms-apps://itunes.apple.com/cn/app/id414478124?mt=8';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else if (Platform.isAndroid) {
      // TODO: 安卓apk下载地址
      String url =
          'https://github.com/tec8297729/shop_demo_flutter/releases/download/v$appVersion/app-release.apk';
      try {
        // TODO: 下载后的apk替换换新名称 flutter.apk(自定义)
        OtaUpdate().execute(url, destinationFilename: 'baixing.apk').listen(
          (OtaEvent event) {
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
                PermUtils.storagePerm(); // 权限申请
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
          UpdateHeader(version: appVersion), // 头部
          UpdateInstr(data: widget?.info),
          bottomW(),
        ],
      ),
    );
    // return ScaleTransition(
    //   alignment: Alignment.center, // 指定缩放中心点
    //   scale: animation,
    //   child: Container(
    //     width: widthWrap,
    //     height: ScreenUtil().setHeight(740),
    //     color: Colors.transparent,
    //     child: Column(
    //       children: <Widget>[
    //         UpdateHeader(version: appVersion), // 头部
    //         UpdateInstr(data: widget?.info),
    //         bottomW(),
    //       ],
    //     ),
    //   ), // 你要显示的组件
    // );
  }

  /// 底部组件
  Widget bottomW() {
    Widget _child = upAppBtn();
    if (downloadFlag) {
      // 下载中，进度条
      _child = downProgressWidget();
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

  /// 进度条
  Widget downProgressWidget() {
    final double progWidth = ScreenUtil().setHeight(36);
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      width: ScreenUtil().setWidth(360),
      child: PhysicalModel(
        color: Colors.transparent,
        // elevation: 2,
        borderRadius: BorderRadius.circular(8), // 裁剪圆度
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: progWidth,
          child: Stack(
            children: <Widget>[
              Container(
                height: progWidth,
                child: LinearProgressIndicator(
                  value: downAppProgress / 100, // 加载进度
                  valueColor: AlwaysStoppedAnimation(Color(0xff009FF9)),
                  backgroundColor: Colors.black12,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  downAppProgress > 0 ? '下载进度:$downAppProgress%' : '准备下载中...',
                  style: TextStyle(
                      color: Colors.black, fontSize: ScreenUtil().setSp(18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 底部升级按钮
  Widget upAppBtn() {
    return Container(
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
          _updateVersion(); // 版本检查及升级
          setState(() {
            downloadFlag = true;
          });
        },
      ),
    );
  }
}
