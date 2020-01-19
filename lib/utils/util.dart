import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class Util {
  /// 防抖函数
  Function debounce(Function fn, [int t = 30]) {
    Timer _debounce;
    return (data) {
      // 还在时间之内，抛弃上一次
      if (_debounce?.isActive ?? false) _debounce.cancel();

      _debounce = Timer(Duration(milliseconds: t), () {
        fn(data);
      });
    };
  }

  /// tosat提示
  static toastTips(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      // gravity: ToastGravity.CENTER, // 提示位置
      fontSize: 18, // 提示文字大小
    );
  }

  /// 基础权限申请
  static Future initPermissions() async {
    storagePerm();
  }

  /// 存储权限申请
  static Future<bool> storagePerm() async {
    // 权限检查
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission != PermissionStatus.granted) {
      var permissions = await PermissionHandler()
          .requestPermissions([PermissionGroup.storage]);
      return permissions[PermissionGroup.storage] == PermissionStatus.granted;
    }
    return true;
  }
}
