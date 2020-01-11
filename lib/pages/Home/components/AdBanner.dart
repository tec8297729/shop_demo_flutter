import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AdBanner extends StatelessWidget {
  final String adPicture;
  AdBanner({Key key, @required this.adPicture});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Image.network(adPicture),
    // );
    return CachedNetworkImage(
      imageUrl: '$adPicture',
      // 图片读取失败显示的weiget组件
      errorWidget: (context, url, error) => new Icon(Icons.error),
    );
  }
}
