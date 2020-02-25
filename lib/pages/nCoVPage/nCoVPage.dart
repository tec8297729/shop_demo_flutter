import 'package:baixing/components/MyAppBar/MyAppBar.dart';
import 'package:baixing/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'components/NationalEpidemic.dart';
import 'provider/nCoVPage.p.dart';

Color _bgColor = Color(0xFFfed6bb);

/// 疫情信息-新型冠状病毒
class NCoVPage extends StatefulWidget {
  @override
  NCoVPageState createState() => NCoVPageState();
}

class NCoVPageState extends State<NCoVPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "疫情实时跟踪"),
      body: Consumer<NCoVPageStore>(builder: (_, store, child) {
        return Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              color: _bgColor,
              child: ListView(
                children: <Widget>[
                  _headerBg(),
                  _paddingWrap(NationalEpidemic()), // 疫情内容区域
                ],
              ),
            ),
            if (store.loadFlag) _loadingWidget(),
          ],
        );
      }),
    );
  }

  /// wrap层
  Widget _paddingWrap(Widget child) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      margin: EdgeInsets.only(bottom: 50),
      child: child,
    );
  }

  /// 顶部背景图
  Widget _headerBg() {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(358),
      margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(15)),
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: ImageUtils.getAssetImage('asset/ncovImage/bg.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _loadingWidget() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Colors.black38,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitFadingCircle(
            color: Colors.red,
            // size: 100,
          ),
          SizedBox(height: ScreenUtil().setWidth(30)),
          Text(
            '加载中...',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
