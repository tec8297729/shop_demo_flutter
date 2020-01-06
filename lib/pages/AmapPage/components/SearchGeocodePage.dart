import 'package:amap_search_fluttify/amap_search_fluttify.dart';
import 'package:flutter/material.dart';

// 地图坐标查询测试
class SearchGeocodePage extends StatefulWidget {
  @override
  _AmapSearchState createState() => _AmapSearchState();
}

class _AmapSearchState extends State<SearchGeocodePage>
    with AmapSearchDisposeMixin {
  TextEditingController radiusController = TextEditingController();
  TextEditingController latLng1Controller = TextEditingController();
  TextEditingController latLng2Controller = TextEditingController();
  String textAmap;

  @override
  void initState() {
    super.initState();
    radiusController.text = '200';
    latLng1Controller.text = '40';
    latLng2Controller.text = '116.3053';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('地图搜索'),
      ),
      body: Column(
        children: <Widget>[
          latLngWidget(),
          radiusWidget(),

          // 确认查询
          RaisedButton(
            child: Text('查询'),
            onPressed: () async {
              print('object');

              /// 逆地理编码（坐标转地址）
              final reGeocodeList = await AmapSearch.searchReGeocode(
                LatLng(
                  double.parse(latLng1Controller.text),
                  double.parse(latLng2Controller.text),
                ),
                radius: double.parse(radiusController.text),
              );
              print(reGeocodeList.toString());
              setState(() {
                textAmap = reGeocodeList.toString();
              });
            },
          ),

          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(textAmap.toString()),
          ),
        ],
      ),
    );
  }

  // 坐标组件
  Widget latLngWidget() {
    return Row(
      children: <Widget>[
        Container(
          child: Text('LatLng:'),
        ),
        Expanded(
          flex: 1,
          child: TextField(
            controller: latLng1Controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10),
              // 光标移入，底部边框颜色
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: TextField(
            controller: latLng2Controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10),
              // 光标移入，底部边框颜色
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 中间点范围值
  Widget radiusWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextField(
        controller: radiusController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          helperText: 'radius中间点范围值', // 输入框底部的提示信息
          // 光标移入，底部边框颜色
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }
}
