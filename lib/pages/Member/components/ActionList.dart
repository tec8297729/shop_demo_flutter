import 'package:flutter/material.dart';
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
          myListTitle('已领取优惠券'),
          myListTitle('地址管理'),
          myListTitle('客服电话'),
          myListTitle(
            '关于我们',
            onTap: () async {
              // 安卓设备, 强制定位使用插件,而不是整合服务提供客户端处理(有些机型需要设置)

              // 单次定位
              // if (await requestPermission()) {
              //   final location = await AmapLocation.fetchLocation();
              //   LatLng data = await location.latLng;
              //   location.province.then((v) {
              //     print('城市:$v');
              //   });
              //   showDialog(
              //     context: context,
              //     builder: (context) {
              //       print('坐标$data');
              //       return Text('$data');
              //     },
              //   );
              // }

              // 连续定位
              // if (await requestPermission()) {
              //   await for (final location in AmapLocation.listenLocation()) {
              //     // setState(() => _location = location);
              //     location.latLng.then((data) {
              //       print('坐标$data');
              //     });
              //     location.province.then((v) {
              //       print('城市:$v');
              //     });
              //   }
              // }
              print('关于我们点击');
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
