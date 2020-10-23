import 'package:baixing/components/SearchBar/SearchBar.dart';
import 'package:baixing/pages/AppHomePage/Home/provider/homeStroe.p.dart';
import 'package:baixing/provider/locatingStore.dart';
import 'package:baixing/routes/routeName.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart' show Provider, Consumer;

class MyHomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  MyHomeAppBar({this.appBarAlpha});

  final double appBarAlpha;
  @override
  _MyHomeAppBarState createState() => _MyHomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MyHomeAppBarState extends State<MyHomeAppBar> {
  String myCityName;
  GlobalKey _key = GlobalKey();
  LocatingStore locatingStore;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) {
      initMyAddress();
    });
  }

  /// 更新定位信息
  initMyAddress() async {
    try {
      await locatingStore?.getMyAddress(); // 获取定位信息
      locatingStore?.locatingNotifyListeners();
      myCityName = locatingStore?.myCityName;
    } catch (e) {}
  }

  // 跳转搜索页面
  goSearchPage() {
    Navigator.pushNamed(context, RouteName.searchPage);
  }

  @override
  Widget build(BuildContext context) {
    HomeStore homeStore = Provider.of<HomeStore>(context);
    locatingStore = Provider.of<LocatingStore>(context);

    double _appHeight =
        _key.currentContext?.findRenderObject()?.semanticBounds?.bottom ?? 0;
    // 存当前组件高度
    homeStore?.saveMyAppBarHeight(_appHeight);

    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: headerWidget(),
    );
  }

  // 顶部栏组件
  Widget headerWidget() {
    return Container(
      key: _key,
      decoration: BoxDecoration(
        color: Color(0xFFD1222A),
        // 阴影
        boxShadow: widget.appBarAlpha > 0.2
            ? [BoxShadow(color: Colors.black12, blurRadius: 4.5)]
            : null,
      ),
      child: Container(
        height: ScreenUtil().setHeight(160),
        padding:
            EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0),
        decoration: BoxDecoration(
          // 动态改变盒子的背景色--透明度，滑动
          color:
              Color.fromARGB((widget.appBarAlpha * 255).toInt(), 255, 255, 255),
        ),
        child: Consumer<LocatingStore>(builder: (_, store, child) {
          myCityName = store?.myCityName;
          return SearchBar(
            searchBarType: widget.appBarAlpha > 0.2
                ? SearchBarType.homeLight // 大于二分之一时，高亮显示
                : SearchBarType.home,
            defaultText: '网红热门打卡 美食、景点、酒店',
            leftTitle: myCityName, // 默认显示上海
            leftButtonClick: () => showCityModel(),
            speakClick: () => goSearchPage(),
            inputBoxClick: () => goSearchPage(),
            rightButtonClick: () => goSearchPage(),
          );
        }),
      ),
    );
  }

  /// 显示省市区选择
  showCityModel() async {
    Result result = await CityPickers.showCitiesSelector(
      context: context,
      hotCities: [
        HotCity(name: '上海市', id: 310100),
        HotCity(name: '北京市', id: 110100),
      ],
    );
    setState(() {
      if (result != null) {
        myCityName = result.cityName;
      }
    });
  }
}
