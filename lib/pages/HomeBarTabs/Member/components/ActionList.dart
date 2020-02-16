import 'dart:convert';
import 'package:baixing/components/DebugBtn/DebugBtn.dart';
import 'package:baixing/components/UpdateAppVersion/UpdateAppVersion.dart';
import 'package:baixing/routes/routerName.dart';
import 'package:baixing/utils/util.dart' show Util;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:majascan/majascan.dart';
import 'package:flutter/material.dart';
import 'package:jh_debug/jh_debug.dart';

// 坚向的列表
class ActionList extends StatefulWidget {
  @override
  _ActionListState createState() => _ActionListState();
}

class _ActionListState extends State<ActionList> {
  JPush jPush;
  Map<String, dynamic> pushParams; // 推送参数

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  /// 初始化推送
  initPlatformState() async {
    jPush = JPush();
    try {
      // 监听极光推送事件
      jPush.addEventHandler(
        // 接收通知回调方法。
        onReceiveNotification: (Map<String, dynamic> message) async {
          String argStr = await message['extras']['cn.jpush.android.EXTRA'];
          pushParams = jsonDecode(argStr);
        },
        // 点击通知回调方法。
        onOpenNotification: (Map<String, dynamic> message) async {
          Navigator.pushNamed(context, RouterName.goodsDetailsInfo, arguments: {
            'goodsId': pushParams['goodsId'],
          });
        },
      );
    } on PlatformException {
      // 配置不对或是服务器版本不对,都会进入此区域
      print('平台版本获取失败,请检查');
    }
    // 初始化,监听相关方法要在初始化之前
    jPush.setup(
        // appKey: "替换成你自己的 appKey",
        // channel: "theChannel",
        // production: false,
        // debug: false, // 设置是否打印 debug 日志
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          myListTitle('地图调用', onTap: () {
            Navigator.of(context).pushNamed(RouterName.amapPage);
          }),
          // myListTitle('测试', onTap: () async {}),
          myListTitle('扫一扫', onTap: () async {
            String qrResult = await MajaScan.startScan(
              title: 'QRcode scanner',
              // barColor: Colors.red, // 顶部bar背景色
              // titleColor: Colors.green, // 标题颜色
              qRCornerColor: Colors.blue, // 扫码边框色
              qRScannerColor: Colors.deepPurple, // 扫码线颜色
              flashlightEnable: true,
            );
            Util.toastTips('扫一扫结果>>$qrResult');
          }),
          myListTitle(
            '推送通知',
            onTap: () async {
              // 创建一个通知
              LocalNotification _localNotification = LocalNotification(
                  id: 232323,
                  buildId: 2,
                  title: '京宫二锅头限量免费送', // 标题
                  content: '好货不断,每天惊喜机器人免费抢',
                  fireTime: DateTime.now(), // 推送时间
                  // 传入参数
                  extra: {"goodsId": "035b55e444db4d308fd963543c7d884f"});
              // 发送本地通知
              jPush.sendLocalNotification(_localNotification);
            },
          ),
          myListTitle('更新APP', onTap: () async {
            getNewAppVer(forceUpdate: true); // app更新检查
          }),
          debugBtnStack(),
        ],
      ),
    );
  }

  /// 调试按钮
  Widget debugBtnStack() {
    return Stack(
      children: <Widget>[
        DebugBtn(
          child: myListTitle('调试入口>密令双击长按上下移'),
          success: () {
            jhDebug.showDebugBtn();
          },
        ),
      ],
    );
  }

  // 通用listTitle
  Widget myListTitle(String title, {Function onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: ListTile(
        leading: Icon(Icons.blur_circular), // 左侧图
        trailing: Icon(Icons.arrow_right), // 右侧图
        title: Text(title), // 标题
        onTap: onTap,
      ),
    );
  }
}
