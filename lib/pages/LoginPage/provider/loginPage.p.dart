import 'package:flutter/material.dart';

class LoginPageStore extends ChangeNotifier {
  ScrollController pageScrollContr = ScrollController();
  double bottomMargin = 0;
  set setBottomMargin(data) => bottomMargin = data;

  /// 滚动键盘高度
  scrollJumpTo([double value = 0]) {
    if (bottomMargin > 0) {
      pageScrollContr.animateTo(
        bottomMargin - 100 + value,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
