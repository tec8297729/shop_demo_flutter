import 'package:baixing/utils/util.dart';
import 'package:flutter/material.dart';

// 楼层标题图片
class FloorTitle extends StatelessWidget {
  final String pictureAddress;
  FloorTitle({Key key, @required this.pictureAddress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Image(image: ImageUtils.getNetWorkImage(pictureAddress)),
    );
  }
}
