import 'dart:math';
import 'package:baixing/pages/nCoVPage/provider/nCoVPage.p.dart';
import 'package:baixing/provider/locatingStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'ChartsLegend.dart';
import 'MyAttention.dart';
import 'NCTItle.dart';

/// 全国疫情
class NationalEpidemic extends StatefulWidget {
  @override
  _NationalEpidemicState createState() => _NationalEpidemicState();
}

class _NationalEpidemicState extends State<NationalEpidemic>
    with SingleTickerProviderStateMixin {
  final Color _desColor = Color(0xFFD0D0D0);
  AnimationController controller;
  Animation<double> animation;
  bool getFlag = true; // 是否可请求
  NCoVPageStore nCoVPageStore;
  LocatingStore locatingStore;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    animation = Tween<double>(begin: 0, end: 2 * pi).animate(controller)
      ..addStatusListener(animatListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initData();
  }

  initData() async {
    await nCoVPageStore?.initNcvOverall();
  }

  @override
  void dispose() {
    animation.removeStatusListener(animatListener);
    controller.dispose();
    super.dispose();
  }

  animatListener(state) {
    // AnimationStatus.completed 动画结束后状态
    switch (state) {
      case AnimationStatus.completed:
        controller.forward(from: 0);
        break;
      default:
    }
  }

  /// 加载刷新ICON事件
  loadingBtn() async {
    if (!getFlag) return;
    getFlag = false;
    controller.forward(from: 0);
    await locatingStore.getMyAddress();
    await nCoVPageStore.initNcvOverall();
    // 获取省内每个市疫情信息
    await Future.delayed(Duration(seconds: 1));
    await nCoVPageStore.getMyCityData(locatingStore?.myProvinceName);
    setState(() {
      getFlag = true;
      controller.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    nCoVPageStore = Provider.of<NCoVPageStore>(context);
    locatingStore = Provider.of<LocatingStore>(context); // 状态管理,定位相关
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: <Widget>[
          NCTItle(title: '全国疫情', right: _nCTItleRight()),
          _titleDes('统计截至时间  ${nCoVPageStore.newUpTime}'),
          _overallData(),
          Divider(),
          ChartsLegend(), // 图形报表
          Divider(),
          MyAttention(), // 个人地区信息
          Divider(),
        ],
      ),
    );
  }

  /// 标题右侧组件，刷新数据
  Widget _nCTItleRight() {
    return AnimatedBuilder(
      animation: animation,
      child: GestureDetector(
        onTap: loadingBtn, // 更新数据
        child: Tooltip(message: '刷新数据', child: Icon(Icons.autorenew)),
      ),
      builder: (context, child) {
        return Transform.rotate(angle: animation.value, child: child);
      },
    );
  }

  /// 全国疫情数据
  Widget _overallData() {
    return Container(
      height: ScreenUtil().setHeight(180),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: nCoVPageStore.ncvOverallData.length,
        itemBuilder: (context, index) {
          return _overallDataItem(index);
        },
      ),
    );
  }

  /// 疫情item组件
  Widget _overallDataItem(int index) {
    return Consumer<NCoVPageStore>(
      builder: (_, store, __) {
        Color _textColor =
            Color(int.parse(store.ncvOverallData[index]['color']));
        return Container(
          margin: EdgeInsets.only(
              right: index != 4 ? ScreenUtil().setWidth(40) : 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: ScreenUtil().setHeight(50),
                child: Text(
                  store.ncvOverallData[index]['title'], // 标题
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: _textColor,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: ScreenUtil().setHeight(60),
                child: Text(
                  store.ncvOverallData[index]['count'], // 总数据
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(33),
                    color: _textColor,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: ScreenUtil().setHeight(30),
                child: RichText(
                  text: TextSpan(
                    text: '较昨日 ',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      color: _desColor,
                    ),
                    children: <TextSpan>[
                      // 里面可以创建多个不同样式的文字内容
                      TextSpan(
                        text: '${store.ncvOverallData[index]['oldDayCount']}',
                        style: TextStyle(color: _textColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 标题描述
  Widget _titleDes(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      height: ScreenUtil().setWidth(52),
      child: Text(
        title,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(26),
          color: _desColor,
        ),
      ),
    );
  }
}
