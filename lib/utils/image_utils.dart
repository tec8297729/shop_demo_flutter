import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';

class ImageUtils {
  /// 获取网络图片
  ///
  /// [useDiskCache] 是否缓存到本地存储
  ///
  /// [cache] 缓存图片天数
  static ImageProvider getNetWorkImage(
    String url, {
    bool useDiskCache = true,
    int cache = 30,
    Uint8List fallbackImage,
  }) {
    return AdvancedNetworkImage(
      url,
      useDiskCache: useDiskCache,
      cacheRule: CacheRule(maxAge: Duration(days: cache)),
      fallbackAssetImage: 'asset/images/404.jpg',
      fallbackImage: fallbackImage,
    );
  }

  /// 获取网络图片，返回widget组件
  static Widget getNetWorkImageWidget(
    String url, {
    bool useDiskCache = true,
    int cache = 30,
    Uint8List fallbackImage,
    double width,
    double height,
  }) {
    return TransitionToImage(
      image: ImageUtils.getNetWorkImage(url),
      // loadingWidgetBuilder: (_, double progress, __) =>
      //     Image.asset('asset/404.jpg'),
      fit: BoxFit.contain,
      placeholder: const Icon(Icons.refresh),
      width: width,
      height: height,
      enableRefresh: true,
    );
  }
}
