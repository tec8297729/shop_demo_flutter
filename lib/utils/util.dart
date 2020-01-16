import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

class Util {
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
}
