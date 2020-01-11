import 'dart:async';
import 'package:baixing/components/DebugBtn/DebugBtn.dart';
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
    initMap();
  }

  initMap() async {
    ///  如果你觉得引擎的日志太多,  可以关闭Fluttify引擎的日志
    // await enableFluttifyLog(false); //  关闭log
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
            // _askedToLead();
            Navigator.of(context).pushNamed('/amapPage');
          }),
          myListTitle('已领取优惠券', onTap: () {
            // Navigator.of(context).pushNamed('/flowLayout');
          }),
          DebugBtn(
            child: myListTitle('地址管理'),
            success: () {},
          ),
          myListTitle('客服电话'),
          myListTitle(
            '关于我们',
            onTap: () async {
              print('关于我们点击');
              // show(context: context, message: '324234');
              jhDebug.showDebugBtn();
            },
          ),
        ],
      ),
    );
  }

  static void show({@required BuildContext context, @required String message}) {
    //创建一个OverlayEntry对象
    OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
      //外层使用Positioned进行定位，控制在Overlay中的位置
      return Positioned(
        top: MediaQuery.of(context).size.height * 0.7,
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.bug_report), // 设置按钮icon图标
          backgroundColor: Colors.pink, // 按钮的背景颜色
          mini: false, // 是否是小图标
          elevation: 10, // 未点击时的阴影值
          highlightElevation: 20, // 点击状态时的阴影值
        ),
      );
    });
    //往Overlay中插入插入OverlayEntry
    Overlay.of(context).insert(overlayEntry);
    //两秒后，移除Toast
    // new Future.delayed(Duration(seconds: 2)).then((value) {
    //   overlayEntry.remove();
    // });
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
