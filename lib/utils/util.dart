import 'dart:async';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
export 'sp_util.dart' show SpUtil;
export 'perm_utils.dart' show PermUtils;
export 'image_utils.dart' show ImageUtils;
export 'log_util.dart' show LogUtil;
export 'view_utils.dart' show ViewUtils;

class Util {
  /// 防抖函数,间隔毫秒
  static Function debounce(Function fn, [int milliseconds = 30]) {
    Timer _debounce;
    return ([data]) {
      // 还在时间之内，抛弃上一次
      if (_debounce?.isActive ?? false) _debounce.cancel();

      _debounce = Timer(Duration(milliseconds: milliseconds), () {
        fn([data]);
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

  /// 获取当前位置，返回Latlng类
  static Future<LatLng> getMyLatLng() async {
    Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
    await geolocator.checkGeolocationPermissionStatus();
    Position position = await Geolocator().getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }
}
