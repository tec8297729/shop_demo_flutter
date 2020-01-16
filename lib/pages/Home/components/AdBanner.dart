import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

class AdBanner extends StatelessWidget {
  final String adPicture;
  AdBanner({Key key, @required this.adPicture});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Image.network(adPicture),
    // );

    return Image(
      image: AdvancedNetworkImage(
        '$adPicture',
        useDiskCache: true,
        cacheRule: CacheRule(maxAge: const Duration(days: 30)),
      ),
    );
  }
}
