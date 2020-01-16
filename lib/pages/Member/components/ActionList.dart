import 'dart:async';
import 'package:baixing/utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:majascan/majascan.dart';
import '../../../components/DebugBtn/DebugBtn.dart';
import 'package:flutter/material.dart';
import 'package:jh_debug/jh_debug.dart';
import 'package:permission_handler/permission_handler.dart';

// 坚向的列表
class ActionList extends StatefulWidget {
  @override
  _ActionListState createState() => _ActionListState();
}

class _ActionListState extends State<ActionList> {
  @override
  void initState() {
    super.initState();
  }

  // 权限GPS
  Future<bool> requestPermission() async {
    final permissions = await PermissionHandler()
        .requestPermissions([PermissionGroup.location]);
    print('判断GPS$permissions');
    if (permissions[PermissionGroup.location] == PermissionStatus.granted) {
      return true;
    } else {
      print('没有定位权限');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          myListTitle('地图调用', onTap: () {
            Navigator.of(context).pushNamed('/amapPage');
          }),
          myListTitle('已领取优惠券', onTap: () async {}),
          myListTitle('扫一扫', onTap: () async {
            String qrResult = await MajaScan.startScan(
              title: 'QRcode scanner',
              // barColor: Colors.red, // 顶部bar背景色
              // titleColor: Colors.green, // 标题颜色
              qRCornerColor: Colors.blue, // 扫码边框色
              qRScannerColor: Colors.deepPurple, // 扫码线颜色
              flashlightEnable: true,
            );
            print('扫一扫结果>>$qrResult');
            Util.toastTips('扫一扫结果>>$qrResult');
          }),
          myListTitle(
            '关于我们',
            onTap: () async {
              print('关于我们点击');
            },
          ),
          DebugBtn(
            child: myListTitle('调试入口管理'),
            success: () {
              jhDebug.showDebugBtn();
            },
          ),
        ],
      ),
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
