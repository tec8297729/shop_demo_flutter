import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:amap_search_fluttify/amap_search_fluttify.dart';
import 'package:baixing/components/SearchBar/SearchBar.dart';
import 'package:baixing/routes/routerName.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  MyAppBar({this.appBarAlpha});

  final double appBarAlpha;
  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  // Size get preferredSize => Size.fromHeight(kToolbarHeight + (0.0));
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar>
    with AmapSearchDisposeMixin, AmapLocationDisposeMixin {
  String myAddress;
  @override
  void initState() {
    super.initState();
    getMyAddress();
  }

  // 获取自己当前位置
  Future getMyAddress() async {
    try {
      Location location = await AmapLocation.fetchLocation();
      LatLng myLatLng = await location.latLng;
      ReGeocode reGeocodeList = await AmapSearch.searchReGeocode(
        myLatLng, // 坐标
        radius: 300.0, // 最大可找半径
      );
      myAddress = await reGeocodeList.cityName; // 获取地址
    } catch (e) {}
    if (myAddress?.isEmpty ?? false) {
      myAddress = '上海';
    }
  }

  // 跳转搜索页面
  goSearchPage() {
    Navigator.pushNamed(context, RouterName.searchPage);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      child: headerWidget(),
      removeBottom: true,
    );
  }

  // 顶部栏组件
  Widget headerWidget() {
    Widget searchWidget = SearchBar(
      searchBarType: widget.appBarAlpha > 0.2
          ? SearchBarType.homeLight // 大于二分之一时，高亮显示
          : SearchBarType.home,
      defaultText: '网红热门打卡 美食、景点、酒店',
      leftTitle: myAddress, // 默认显示上海
      leftButtonClick: () => showCityModel(),
      speakClick: () => goSearchPage(),
      inputBoxClick: () => goSearchPage(),
      rightButtonClick: () => goSearchPage(),
    );

    // 搜索整体组件
    Widget searWrap = Container(
      decoration: BoxDecoration(
        color: Color(0xFFD1222A),
        // 阴影
        boxShadow: widget.appBarAlpha > 0.2
            ? [BoxShadow(color: Colors.black12, blurRadius: 4.5)]
            : null,
      ),
      child: Container(
        height: ScreenUtil().setHeight(160),
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        decoration: BoxDecoration(
          // 动态改变盒子的背景色--透明度，滑动
          color:
              Color.fromARGB((widget.appBarAlpha * 255).toInt(), 255, 255, 255),
        ),
        child: searchWidget,
      ),
    );
    return searWrap;
  }

  /// 显示省市区选择
  showCityModel() async {
    Result result2 = await CityPickers.showCitiesSelector(
      context: context,
      hotCities: [
        HotCity(name: '上海市', id: 310100),
        HotCity(name: '北京市', id: 110100),
      ],
    );
    setState(() {
      myAddress = result2.cityName;
    });
  }
}
