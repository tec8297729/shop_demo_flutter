import 'dart:developer';
import 'package:ana_page_loop/ana_page_loop.dart';
import 'package:baixing/utils/util.dart';
import 'package:jh_debug/jh_debug.dart';
import 'Home/Home.dart';
import 'Cart/Cart.dart';
import 'Category/Category.dart';
import 'Member/Member.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../components/DoubleBackExitApp/DoubleBackExitApp.dart';
import './provider/appHomePageStore.p.dart';
import '../../components/UpdateAppVersion/UpdateAppVersion.dart'
    show getNewAppVer;
import '../../services/servcie_url.dart';

class AppHomePage extends StatefulWidget {
  final params;

  AppHomePage({
    Key key,
    this.params,
  }) : super(key: key);

  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> with PageViewListenerMixin {
  int currentIndex = 0; // 接收bar当前点击索引
  PageController pageController;
  AppHomePageStore appHomePageStore;

  // 导航菜单渲染数据源
  List<Map<String, dynamic>> barData = [
    {
      'title': '首页',
      'icon': CupertinoIcons.home,
      'body': Home(),
    },
    {
      'title': '分类',
      'icon': CupertinoIcons.search,
      'body': Category(),
    },
    {
      'title': '购物车',
      'icon': CupertinoIcons.shopping_cart,
      'body': Cart(),
    },
    {
      'title': '会员中心',
      'icon': CupertinoIcons.profile_circled,
      'body': Member(),
    },
  ];

  @override
  void initState() {
    super.initState();
    handleCurrentIndex();
    _initUtils();
    _widgetsBinding();
  }

  @override
  PageViewMixinData initPageViewListener() {
    return PageViewMixinData(
      controller: pageController,
      tabsData: ['首页', '分类', '购物车', '我的中心'],
    );
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
  }

  @override
  void didPop() {
    super.didPop();
  }

  @override
  void didPush() {
    super.didPush();
  }

  @override
  void didPushNext() {
    super.didPushNext();
  }

  /// 初始化tabs默认显示索引页
  handleCurrentIndex() {
    if (widget.params != null) {
      // 默认加载页面
      currentIndex = widget.params['pageId'] >= (barData.length)
          ? (barData.length - 1)
          : widget.params['pageId'];
    }
    // 初始化tab内容区域参数
    pageController = PageController(
      initialPage: currentIndex, // 默认显示哪个widget组件
      keepPage: true, // 是否开启缓存，即回退也会在当时的滚动位置
    );
  }

  /// 初始化插件工具
  _initUtils() {
    jhDebug.init(
      context: context,
      btnTitle1: '疫情1',
      btnTap1: () {
        LogUtil.p('切换成mock数据接口');
        nCoVUrl = nCoVUrl2;
      },
      btnTitle2: '疫情2',
      btnTap2: () {
        LogUtil.p('切换成api公用接口');
        nCoVUrl = nCoVUrl3;
      },
    );
  }

  /// 构建第一帧处理
  _widgetsBinding() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      PermUtils.initPermissions(); // 手机权限申请
      getNewAppVer(); // app更新检查
      jhDebug.showDebugBtn(); // 显示jhDebug调试按钮
      appHomePageStore.saveController(pageController); // 存页面pageController控制器
    });
  }

  @override
  Widget build(BuildContext context) {
    // 初始化设计稿尺寸
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    appHomePageStore = Provider.of<AppHomePageStore>(context);

    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        appHomePageStore.getGrayTheme ? Color(0xff757575) : Colors.transparent,
        BlendMode.color,
      ),
      child: _scaffoldBody(),
    );
    // return _scaffoldBody();
  }

  /// 页面Scaffold层组件
  Widget _scaffoldBody() {
    return Scaffold(
      body: PageView(
        controller: pageController, // 控制器
        children: bodyWidget(),
        pageSnapping: false, // 设置为false可禁用页面捕捉
        // 监听当前滑动到的页数
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),

      // 底部栏
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // 只有设置fixed类型，底部bar才会显示所有的文字
          currentIndex: currentIndex, // 当前活动的bar索引
          // 点击事件
          onTap: (int idx) {
            setState(() {
              currentIndex = idx; // 存当前点击索引值
            });
            pageController.jumpToPage(idx); // 跳转到指定页
          },
          items: generateBottomBars(), // 底部菜单导航
        ),
      ),
    );
  }

  // 视图内容区域
  List<Widget> bodyWidget() {
    try {
      List<Widget> bodyList = barData.map((itemWidget) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // 内容区域
            if (itemWidget['body'] != null)
              itemWidget['body'],

            // 自定义退出APP的动画组件
            Positioned(
              bottom: 20,
              child: DoubleBackExitApp(),
            ),
          ],
        );
      }).toList();
      return bodyList;
    } catch (e) {
      throw Exception('barData导航菜单数据缺少body参数，或非IconData类型, errorMsg:$e');
    }
  }

  // 生成底部菜单导航
  List<BottomNavigationBarItem> generateBottomBars() {
    List<BottomNavigationBarItem> list = [];
    for (var idx = 0; idx < barData.length; idx++) {
      list.add(BottomNavigationBarItem(
        icon: Icon(
          barData[idx]['icon'], // 图标
          size: 28,
        ),
        title: Text(
          barData[idx]['title'],
          // 自定义样式
          // style: TextStyle(
          //   color: (currentIndex == idx ? Colors.blueGrey : Colors.black),
          // ),
        ),
      ));
    }
    return list;
  }
}
