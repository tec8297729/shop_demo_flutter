import 'package:baixing/components/PageLoding/PageLoding.dart';
import 'package:baixing/components/SearchBar/SearchBar.dart';
import 'package:baixing/service/service_method.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/AdBanner.dart';
import 'components/FloorContent.dart';
import 'components/FloorTitle.dart';
import 'components/HotGoods.dart';
import 'components/LeaderPhone.dart';
import 'components/Recommend.dart';
import 'components/SwiperDiy.dart';
import 'components/TopNavigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart'; // 上拉加载插件

const APPBAR_SCROLL_OFFSET = 100; // 滚动透明度*的基数

class Home extends StatefulWidget {
  Home({Key key, this.params}) : super(key: key);
  final params;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int page = 1;
  List<Map> hotGoodsList = [];
  Map homeData; // 首页数据
  ScrollController scrollControll = ScrollController(); // 滚动控制器
  double appBarAlpha = 0; // 顶部透明度

  @override
  void initState() {
    super.initState();
    _getHotGoods();
    getHomeData();

    scrollControll.addListener(_onScroll);
  }

  // 监听页面滚动事件
  _onScroll() {
    // 滚动的值 除以 基数值，低于你定义的滚动高度都是0以内
    double alpha = scrollControll.position.pixels / APPBAR_SCROLL_OFFSET;
    // 当小于0的时候透明
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      // 大于1时，透明度直接1不透明
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    // print('滚动值>>$alpha');
  }

  // 获取热门商品列表
  void _getHotGoods() async {
    Map formPage = {'page': page};
    var res = await getHomePageBeloContent(formPage);
    List<Map> newGoodsList = (res['data'] as List).cast<Map>();
    setState(() {
      hotGoodsList.addAll([...newGoodsList]);
      page++;
    });
  }

  // 获取首页数据
  Future getHomeData() async {
    Map newHomeData = await getHomePageContent();
    setState(() {
      homeData = newHomeData;
    });
  }

  // FutureBuilder组件请求数据
  _fetchData() async {
    return homeData;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // 使用缓存组件调用
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 内容区域
          contextWrap(),
          // 顶部区域
          headerWidget(),
        ],
      ),
    );
  }

  // 跳转搜索页面
  goSearchPage() {
    Navigator.pushNamed(context, '/searchPage');
  }

  // 顶部栏组件
  Widget headerWidget() {
    Widget searchWidget = SearchBar(
      searchBarType: appBarAlpha > 0.2
          ? SearchBarType.homeLight // 大于二分之一时，高亮显示
          : SearchBarType.home,
      defaultText: '网红热门打卡 美食、景点、酒店',
      leftButtonClick: () => goSearchPage(),
      speakClick: () => goSearchPage(),
      inputBoxClick: () => goSearchPage(),
      rightButtonClick: () => goSearchPage(),
    );

    // 搜索整体组件
    Widget searWrap = Container(
      decoration: BoxDecoration(
        // 线性渐变颜色
        gradient: LinearGradient(
          colors: [
            Color(0x66000000),
            Colors.transparent, // 透明
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        // 阴影
        boxShadow: appBarAlpha > 0.2
            ? [BoxShadow(color: Colors.black12, blurRadius: 4.5)]
            : null,
      ),
      child: Container(
        height: ScreenUtil().setHeight(160),
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        decoration: BoxDecoration(
          // 动态改变盒子的背景色--透明度，滑动
          color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
        ),
        child: searchWidget,
      ),
    );

    return Column(
      children: <Widget>[
        // 模式1：内置透明组件
        // Opacity(
        //   opacity: appBarAlpha,
        //   child: searWrap,
        // ),

        // 模式2：带透明底色
        searWrap,
      ],
    );
  }

  // 内容区wrap层
  Widget contextWrap() {
    return MediaQuery.removePadding(
      context: context,
      child: FutureBuilder(
        future: _fetchData(),
        builder: (context, snap) {
          if (snap.hasData) {
            return homeContextWidget(snap);
          }
          // 加载中组件
          return loadingWidget();
        },
      ),
    );
  }

  // 内容区组件
  Widget homeContextWidget(AsyncSnapshot snap) {
    // print('首页返回数据>>${snap.data}');
    assert(snap.data['data'] != null);
    var data = snap.data['data'];
    List<Map> swiperList = (data['slides'] as List).cast();
    List<Map> navigatorList = (data['category'] as List).cast();
    // 广告AD字段
    String adPicture = data['advertesPicture']['PICTURE_ADDRESS'];
    Map leaderData = data['shopInfo']; // 店长相关字段
    List<Map> recommendList = (data['recommend'] as List).cast<Map>();

    // 楼层字段
    String floor1Title = data['floor1Pic']['PICTURE_ADDRESS'];
    String floor2Title = data['floor2Pic']['PICTURE_ADDRESS'];
    String floor3Title = data['floor3Pic']['PICTURE_ADDRESS'];
    List<Map> floor1 = (data['floor1'] as List).cast();
    List<Map> floor2 = (data['floor2'] as List).cast();
    List<Map> floor3 = (data['floor3'] as List).cast();

    return _easyRefresh(
      child: ListView(
        // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        children: <Widget>[
          SwiperDiy(swiperDataList: swiperList), // 轮播
          TopNavigator(navigatorList: navigatorList), // nav区域
          AdBanner(adPicture: adPicture), // 广告AD
          // 店长电话组件
          LeaderPhone(
            leaderImg: leaderData['leaderImage'],
            phone: leaderData['leaderPhone'],
          ),
          // 推荐组件
          Recommend(listData: recommendList),

          FloorTitle(pictureAddress: floor1Title),
          FloorContent(listData: floor1),
          FloorTitle(pictureAddress: floor2Title),
          FloorContent(listData: floor2),
          FloorTitle(pictureAddress: floor3Title),
          FloorContent(listData: floor3),

          // 火爆专区
          HotGoods(
            hotGoodsList: hotGoodsList,
          ),
        ],
      ),
    );
  }

  // 加载中动画组件
  Widget loadingWidget() {
    return EasyRefresh(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: ScreenUtil().setHeight(1334)),
        child: PageLoading(),
      ),
      header: ClassicalHeader(
        noMoreText: '', // 不显示 没有更多 文字
        showInfo: true, // 显示当前刷新时间
        infoText: '上次刷新时间: %T',
        refreshText: '下拉加载...',
        refreshReadyText: '下拉加载刷新',
        refreshingText: '加载中...',
        refreshedText: '加载完成',
        refreshFailedText: '加载失败',
      ),
      onRefresh: () async {
        getHomeData();
      },
    );
  }

  // 上拉加载组件配置
  Widget _easyRefresh({@required Widget child}) {
    return EasyRefresh(
      scrollController: scrollControll, // 滚动控制器
      header: ClassicalHeader(
        noMoreText: '', // 不显示 没有更多 文字
        showInfo: true, // 显示当前刷新时间
        infoText: '上次刷新时间: %T',
        refreshText: '下拉加载...',
        refreshReadyText: '下拉加载刷新',
        refreshingText: '加载中...',
        refreshedText: '加载完成',
        refreshFailedText: '加载失败',
      ),
      footer: ClassicalFooter(
        // enableInfiniteLoad: false, // 加载完成后隐藏底部
        bgColor: Colors.white,
        textColor: Colors.pink,
        noMoreText: '', // 不显示 没有更多 文字
        showInfo: true, // 显示当前刷新时间
        infoText: '上次刷新时间: %T',
        loadReadyText: '上拉加载...',
        loadingText: '加载中...',
        loadedText: '加载完成',
        loadFailedText: '加载失败',
      ),
      // 上拉加载
      onLoad: () async {
        _getHotGoods();
        print('加载更多$page');
      },
      child: child,
    );
  }
}
