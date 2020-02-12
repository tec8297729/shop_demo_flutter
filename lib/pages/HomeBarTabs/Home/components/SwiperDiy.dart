import 'package:baixing/routes/routerName.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/// 轮播组件
/// [swiperDataList] 轮播list数据
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy({Key key, @required this.swiperDataList});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      height: ScreenUtil().setHeight(370),
      child: Swiper(
        autoplay: true, // 自动播放
        // viewportFraction: 0.8,
        // scale: 0.9,
        // 分页指示器功能
        pagination: SwiperPagination(),
        itemCount: swiperDataList.length,
        itemBuilder: (BuildContext context, int index) {
          return CachedNetworkImage(
            imageUrl: '${swiperDataList[index]['image']}',
            fit: BoxFit.cover,
            // 图片读取失败显示的weiget组件
            errorWidget: (context, url, error) => new Icon(Icons.error),
          );
        },
        // 轮播点击事件
        onTap: (index) {
          Navigator.pushNamed(context, RouterName.goodsDetailsInfo, arguments: {
            'goodsId': swiperDataList[index]['goodsId'],
          });
        },
      ),
    );
  }
}
