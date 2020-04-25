import 'package:baixing/pages/AppHomePage/Home/provider/homeStroe.p.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'components/SliverAppBarDelegate.dart';
import 'components/BottomTags.dart';
import 'components/TopTitle.dart';

class SliverFiedHeader extends StatefulWidget {
  @override
  _SliverFiedHeaderState createState() => _SliverFiedHeaderState();
}

class _SliverFiedHeaderState extends State<SliverFiedHeader> {
  GlobalKey _header = GlobalKey();
  double headerHeight = 0;
  HomeStore homeStore;

  @override
  Widget build(BuildContext context) {
    homeStore = Provider.of<HomeStore>(context);
    RenderObject renderObject = _header.currentContext?.findRenderObject();
    // 获取组件高
    headerHeight = renderObject?.semanticBounds?.size?.height ?? 0;
    homeStore?.saveTopTitleHeight(headerHeight);

    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: SliverAppBarDelegate(
        minHeight: ScreenUtil().setHeight(170),
        maxHeight: ScreenUtil().setHeight(170),
        child: Container(
          key: _header,
          width: double.infinity,
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
