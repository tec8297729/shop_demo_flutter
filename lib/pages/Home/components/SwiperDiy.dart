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
      height: ScreenUtil().setHeight(370),
      child: Swiper(
        autoplay: true, // 自动播放
        // viewportFraction: 0.8,
        // scale: 0.9,
        // 分页指示器功能
        pagination: SwiperPagination(),
        itemCount: swiperDataList.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            '${swiperDataList[index]['image']}',
            fit: BoxFit.fill,
          );
        },
        // 轮播点击事件
        onTap: (index) {
          Navigator.pushNamed(context, '/goodsDetailsInfo', arguments: {
            'goodsId': swiperDataList[index]['goodsId'],
          });
        },
      ),
    );
  }
}
