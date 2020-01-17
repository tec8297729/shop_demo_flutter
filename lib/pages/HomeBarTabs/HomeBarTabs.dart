import '../../pages/Cart/Cart.dart';
import '../../pages/Category/Category.dart';
import '../../pages/Member/Member.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jh_debug/jh_debug.dart';
import 'package:provider/provider.dart';
import '../../components/TipsExitAnimated/TipsExitAnimated.dart';
import '../Home/Home.dart';
import './provider/homeBarTabsStore.p.dart';
// import '../../plugin/asr_manager.dart';

class HomeBarTabs extends StatefulWidget {
  final params;

  HomeBarTabs({
    Key key,
    this.params,
  }) : super(key: key);

  @override
  _HomeBarTabsState createState() => _HomeBarTabsState();
}

class _HomeBarTabsState extends State<HomeBarTabs> {
  int currentIndex = 0; // 接收bar当前点击索引
  PageController pageController;

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

    // 初始化tab内容区域参数
    pageController = PageController(
      initialPage: currentIndex, // 默认显示哪个widget组件
      keepPage: true, // 是否开启缓存，即回退也会在当时的滚动位置
    );
    jhDebug.init(
      context: context,
      btnTap1: () {
        print('btn1>>>');
      },
      btnTitle1: '测试',
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      jhDebug.showDebugBtn();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // 处理默认显示索引
  handleCurrentIndex() {
    if (widget.params != null) {
      // 默认加载页面
      currentIndex = widget.params['pageId'] >= (barData.length)
          ? (barData.length - 1)
          : widget.params['pageId'];
    }
  }

  @override
  Widget build(BuildContext context) {
    // 初始化设计稿尺寸
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
          ..init(context);
    Provider.of<HomeBarTabsStore>(context).saveController(pageController);

    return Scaffold(
      body: PageView(
        controller: pageController, // 控制器
        children: <Widget>[
          ...bodyWidget(),
        ],
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
              child: TipsExitAnimated(),
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
