import 'dart:io';
import 'package:flutter/material.dart';

class AccountPageStore extends ChangeNotifier {
  File avatarImg; // 头像文件
  DateTime selectDate; // 当前用户选择的日期
  /// 保存头像图片
  saveAvatarImg(File imgPath) {
    avatarImg = imgPath;
    notifyListeners();
  }

  /// 保存选择的日期
  saveSelectDate(date) {
    selectDate = date;
    notifyListeners();
  }
}
