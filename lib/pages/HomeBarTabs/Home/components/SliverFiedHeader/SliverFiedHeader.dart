import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/SliverAppBarDelegate.dart';
import 'components/BottomTags.dart';
import 'components/TopTitle.dart';

class SliverFiedHeader extends StatefulWidget {
  @override
  _SliverFiedHeaderState createState() => _SliverFiedHeaderState();
}

class _SliverFiedHeaderState extends State<SliverFiedHeader> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: SliverAppBarDelegate(
        minHeight: ScreenUtil().setHeight(170),
        maxHeight: ScreenUtil().setHeight(170),
        child: Container(
          width: double.infinity,
          // height: ScreenUtil().setHeight(170),
          padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              TopTitle(), // 第一栏
              BottomTags(), // 第二栏tags标签
            ],
          ),
        ),
      ),
    );
  }
}
