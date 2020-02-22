import 'dart:ui';
import 'StackedAreaLineChart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// 筛选按钮下拉菜单组件
class TopTitleScreeningMenu extends StatefulWidget {
  @override
  _TopTitleScreeningMenuState createState() => _TopTitleScreeningMenuState();
}

class _TopTitleScreeningMenuState extends State<TopTitleScreeningMenu> {
  double textSize = 32;
  bool isLoading = false;
  RangeValues sliderValue = RangeValues(0, 120); // 人均价格带滑动值
  List<Map> dataTags1 = [];
  List<Map> dataTags2 = [];

  @override
  void initState() {
    super.initState();

    dataTags1 = [
      {
        'name': '会员领红包',
        'key': 11,
      },
      {
        'name': '配送费优惠',
        'key': 12,
      },
      {
        'name': '赠品优惠',
        'key': 13,
      },
      {
        'name': '特价商品',
        'key': 14,
      },
      {
        'name': '品质联盟红包',
        'key': 15,
      },
      {
        'name': '首单立减',
        'key': 16,
      },
      {
        'name': '津贴优惠',
        'key': 17,
      },
    ];
    dataTags2 = [
      {
        'name': '蜂鸟专送',
        'key': 011,
      },
      {
        'name': '到店自取',
        'key': 012,
      },
      {
        'name': '品牌商家',
        'key': 013,
      },
      {
        'name': '新店',
        'key': 014,
      },
      {
        'name': '接受预订',
        'key': 015,
      },
      {
        'name': '食无忧',
        'key': 016,
      },
      {
        'name': '开发票',
        'key': 017,
      },
    ];

    // 追加字段
    for (var i = 0; i < dataTags1.length; i++) {
      dataTags1[i]['isSelect'] = false;
    }
    for (var i = 0; i < dataTags2.length; i++) {
      dataTags2[i]['isSelect'] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(680),
      child: Stack(
        children: <Widget>[
          // 内容区域
          ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                height: ScreenUtil().setHeight(40),
                child: Text('优惠活动'),
              ),
              tagsWrap(dataTags1),
              Container(
                margin: EdgeInsets.all(20),
                height: ScreenUtil().setHeight(40),
                child: Text('商家服务'),
              ),
              tagsWrap(dataTags2),
              intervalCharts(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: bottomWidget(),
          ),
        ],
      ),
    );
  }

  // 标签组件
  Widget tagsWrap(List<Map> data) {
    double _width = (MediaQuery.of(context).size.width - 50) / 3;
    List<Widget> tagsWidget = [];

    for (var i = 0; i < data.length; i++) {
      tagsWidget.add(GestureDetector(
        onTap: () async {
          setState(() {
            isLoading = true;
            data[i]['isSelect'] = !data[i]['isSelect'];
          });

          await Future.delayed(Duration(seconds: 3));
          setState(() {
            isLoading = false;
          });
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          alignment: Alignment.center,
          width: _width,
          height: ScreenUtil().setHeight(70),
          // 是否勾选，背景颜色
          color: data[i]['isSelect'] ? Color(0xFFE6F1FE) : Color(0xFFF8F8F8),
          child: Text(
            data[i]['name'].toString(),
            style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              // 是否勾选，文字颜色
              color: data[i]['isSelect'] ? Color(0xFF3998F4) : Colors.black,
            ),
          ),
        ),
      ));
    }

    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 5,
        children: tagsWidget,
      ),
    );
  }

  /// 价格区间选择
  Widget intervalCharts() {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(300),
      margin: EdgeInsets.only(bottom: 80),
      child: Stack(
        children: <Widget>[
          // 图表
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: ScreenUtil().setHeight(260),
              child: StackedAreaLineChart.withSampleData(),
            ),
          ),
          // 左上角提示文字
          Positioned(
            left: 20,
            top: 10,
            child: Container(
              color: Colors.transparent,
              child: Text('人均价格带'),
            ),
          ),
          // 底部滑动块
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: ScreenUtil().setHeight(90),
              // width: double.infinity,
              child: RangeSlider(
                values: sliderValue, // 当前拖动的值，用于显示动画
                min: 0, // 指定拖动的最小值
                max: 120, // 拖动的最大值
                inactiveColor: Colors.black26, // 未选中的区域颜色
                activeColor: Colors.blue, // 已选中区域的颜色
                divisions: (120 ~/ 5).toInt(), // 把线条切成几份间隔
                labels: RangeLabels(
                    '￥${sliderValue.start}', '￥${sliderValue.end}'), // 滑块上提示内容
                // 拖动值变化时触发
                onChanged: (v) {
                  setState(() {
                    sliderValue = v;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 底部按钮区域
  Widget bottomWidget() {
    bool cleanFlag = false;
    cleanFlag = dataTags1.any((item) => item['isSelect'] == true);

    return Row(
      children: <Widget>[
        expandedBtn(
          onTap: () {
            if (!cleanFlag) return;
            for (var i = 0; i < dataTags1.length; i++) {
              dataTags1[i]['isSelect'] = false;
            }
            for (var i = 0; i < dataTags2.length; i++) {
              dataTags2[i]['isSelect'] = false;
            }
            setState(() {});
          },
          child: Container(
            height: ScreenUtil().setHeight(80),
            color: Colors.white,
            child: Center(
                child: Text(
              '清空',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(textSize),
                color: cleanFlag ? Colors.black : Color(0xFFD1D1D1),
              ),
            )),
          ),
        ),
        // 查看商家
        expandedBtn(
          onTap: () {
            if (isLoading) return;
            Navigator.pop(context);
          },
          child: Container(
            height: ScreenUtil().setHeight(80),
            color: Color(0xFF2393FE),
            child: Center(
              // 加载状态显示另外组件
              child: isLoading
                  ? SpinKitThreeBounce(
                      color: Colors.white,
                      size: ScreenUtil().setSp(44),
                    )
                  : Text(
                      '查看45672个商家',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(textSize),
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  /// 底部通用弹性按钮
  Widget expandedBtn({@required Function onTap, Widget child}) {
    return Expanded(
      flex: 1,
      child: GestureDetector(onTap: onTap, child: child),
    );
  }
}
