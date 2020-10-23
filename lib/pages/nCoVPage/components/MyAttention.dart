import 'package:amap_search_fluttify/amap_search_fluttify.dart';
import 'package:baixing/pages/nCoVPage/components/NCTItle.dart';
import 'package:baixing/pages/nCoVPage/model/myCity_model.dart';
import 'package:baixing/pages/nCoVPage/provider/nCoVPage.p.dart';
import 'package:baixing/provider/locatingStore.dart';

import 'package:baixing/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart' show Provider, Consumer;

// 个人关注疫情信息
class MyAttention extends StatefulWidget {
  @override
  _MyAttentionState createState() => _MyAttentionState();
}

class _MyAttentionState extends State<MyAttention> with AmapSearchDisposeMixin {
  LocatingStore locatingStore;
  Color _textColor = Color(0xFF9E9E9E);
  List<Map> _tagsItemData = [
    {'name': '本地'}
  ];
  int selectTagIndex = 0; // 点击选中tag
  NCoVPageStore nCoVPageStore;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) {
      getData();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// 获取详情数据
  getData() async {
    await locatingStore.getMyAddress();
    await Future.delayed(Duration(seconds: 1)); // 间隔1秒，接口有限制
    await nCoVPageStore.getMyCityData(locatingStore?.myProvinceName);
    LogUtil.p('获取当前城市>>>${locatingStore?.myProvinceName}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    locatingStore = Provider.of<LocatingStore>(context); // 状态管理,定位相关
    nCoVPageStore = Provider.of<NCoVPageStore>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: <Widget>[
          NCTItle(title: '我关注的', right: _titleRight()),
          _tagsWidget(),
          _tagAreaMsg(),
        ],
      ),
    );
  }

  /// tag整体组件
  Widget _tagsWidget() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Row(
        children: <Widget>[
          _tagItem(name: '本地', index: 0),
          // GestureDetector(
          //   onTap: () {},
          //   child: Container(
          //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
          //     margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(16.0),
          //       border: Border.all(color: Color(0xFFDCDCDC)),
          //     ),
          //     child: Row(
          //       children: <Widget>[
          //         Icon(Icons.add, size: ScreenUtil().setSp(32)),
          //         Text(
          //           '订阅',
          //           style: TextStyle(
          //             fontSize: ScreenUtil().setSp(24),
          //             color: Colors.black,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  /// 标签组件
  Widget _tagItem({String name, int index}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        margin: EdgeInsets.only(right: ScreenUtil().setWidth(15)),
        decoration: BoxDecoration(
          color: selectTagIndex == index ? Color(0xFF02875A) : Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: selectTagIndex == index
              ? null
              : Border.all(color: Color(0xFFDCDCDC)),
        ),
        child: Text(
          _tagsItemData[0]['name'].toString(),
          style: TextStyle(
            fontSize: ScreenUtil().setSp(24),
            color: selectTagIndex == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  /// 详细地区疫情信息
  Widget _tagAreaMsg() {
    return Consumer<NCoVPageStore>(builder: (_, store, child) {
      List<Cities> _cities = store.myCityResults?.cities ?? [];
      MyCityResults myCityResults = store.myCityResults;
      return Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: <Widget>[
            /// 本地省数据
            _tagAreaMsgItem(cityName: myCityResults?.provinceName ?? '', data: [
              myCityResults?.confirmedCount ?? 0, // 累计确诊人数
              myCityResults?.deadCount ?? 0, // 死亡人数
              myCityResults?.curedCount ?? 0, // 治愈人数
            ]),
            for (var i = 0; i < _cities.length; i++)
              _tagAreaMsgItem(cityName: _cities[i].cityName, data: [
                _cities[i].confirmedCount, // 累计确诊人数
                _cities[i].deadCount, // 死亡人数
                _cities[i].curedCount, // 治愈人数
              ]),
          ],
        ),
      );
    });
  }

  /// 单个城市数据
  Widget _tagAreaMsgItem({String cityName, List data}) {
    List<Map> itemData = [
      {'name': '确诊', 'count': '0', 'oldCount': '0', 'color': '0xFFC04904'},
      {'name': '死亡', 'count': '0', 'oldCount': '0', 'color': '0xFF585858'},
      {'name': '治愈', 'count': '0', 'oldCount': '0', 'color': '0xFF00754B'},
    ];
    for (var i = 0; i < data.length; i++) {
      if (data[i] != null) {
        itemData[i]['count'] = data[i].toString();
      }
    }

    return Container(
      padding: EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              cityName ?? '',
              style: TextStyle(
                color: Color(0xFF606060),
                fontSize: ScreenUtil().setSp(30),
              ),
            ),
          ),
          for (var i = 0; i < itemData.length; i++)
            Column(
              children: <Widget>[
                _itemRowText(
                  name: itemData[i]['name'],
                  count: itemData[i]['count'],
                  color: Color(int.parse(itemData[i]['color'])),
                ),
                // Container(
                //   child: Text(
                //     '较昨日${itemData[i]['oldCount']}',
                //     style: TextStyle(
                //       fontSize: ScreenUtil().setSp(20),
                //       color: _textColor,
                //     ),
                //   ),
                // ),
              ],
            ),
        ],
      ),
    );
  }

  /// 每行内部文字组件（确诊，死亡，治愈）
  Widget _itemRowText({String name, String count, Color color}) {
    return RichText(
      text: TextSpan(
        text: name,
        style: TextStyle(color: _textColor, fontSize: ScreenUtil().setSp(26)),
        children: <TextSpan>[
          TextSpan(
            text: ' $count',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(32),
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  /// 标题右侧组件
  Widget _titleRight() {
    Color _textColor = Color(0xFF02875A);
    return GestureDetector(
      onTap: () async {
        getData();
      },
      child: Container(
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Icon(
              Icons.add_location,
              color: _textColor,
              size: ScreenUtil().setSp(32),
            ),
            SizedBox(width: ScreenUtil().setWidth(5)),
            Consumer<LocatingStore>(builder: (_, store, __) {
              return Text(
                '您在${store.myCityName}',
                style: TextStyle(
                    color: _textColor, fontSize: ScreenUtil().setSp(24)),
              );
            }),
          ],
        ),
      ),
    );
  }
}
