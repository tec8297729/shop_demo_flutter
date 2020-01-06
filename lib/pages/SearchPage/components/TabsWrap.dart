import 'package:flutter/material.dart';

class TabsWrap extends StatefulWidget {
  TabsWrap({
    this.bottomWidge,
    this.btnTap1,
    this.btnTitle1,
    this.btnTap2,
    this.btnTitle2,
    this.btnTap3,
    this.btnTitle3,
    this.hideBottom = false,
    this.hideCustomTab = true,
    this.customTab,
    this.customTabTitle,
  });

  /// 是否隐藏底部区域块,当为ture隐藏时,bottomWidge自定义底部区域将无效
  final bool hideBottom;

  /// 自定义底部区域组件,如果定义此参数默认定义的底部组件不显示
  final Widget bottomWidge;

  /// 是否隐藏自定义tabs栏,默认true隐藏
  final bool hideCustomTab;

  /// 自定义tabs显示的组件
  final Widget customTab;

  /// 自定义tabs的标题
  final String customTabTitle;

  /// 底部按钮1(开发) 点击事件
  final VoidCallback btnTap1;

  /// 底部按钮1 标题,
  final String btnTitle1;

  /// 底部按钮2(调试) 点击事件
  final VoidCallback btnTap2;

  /// 底部按钮2 标题,
  final String btnTitle2;

  /// 底部按钮3(生产) 点击事件
  final VoidCallback btnTap3;

  /// 底部按钮3 标题,
  final String btnTitle3;

  @override
  _TabsWrapState createState() => _TabsWrapState();
}

class _TabsWrapState extends State<TabsWrap>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Widget> tabsWidget = [];
  List<Widget> tabViewChild = [];
  bool flagTest = false;

  @override
  void initState() {
    super.initState();
    _initTabsWidget();
  }

  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('object');
  }

  _initTabsWidget() {
    tabsWidget = [
      _tabTitle('print'),
      _tabTitle('调试'),
      if (!widget.hideCustomTab || !flagTest) _tabTitle('自定义'),
    ];

    tabViewChild = [
      SingleChildScrollView(
        child: Column(
          children: <Widget>[for (var i = 0; i < 100; i++) Text('data')],
        ),
      ),
      SingleChildScrollView(
        child: Column(
          children: <Widget>[for (var i = 0; i < 100; i++) Text('data22')],
        ),
      ),
      if (!widget.hideCustomTab || !flagTest)
        Center(
          child: Text('自定义你显示的内容'),
        ),
    ];
    _tabController = TabController(length: tabViewChild.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            child: TabBar(
              controller: _tabController,
              tabs: tabsWidget,
            ),
          ),
          Expanded(
            flex: 1,
            child: TabBarView(
              controller: _tabController,
              // 里面定义不同tab显示的内容
              children: tabViewChild,
            ),
          ),

          // 底部区域
          if (!widget.hideBottom)
            _bottomWidget(),
        ],
      ),
    );
  }

  /// tab切换标题
  _tabTitle(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.black),
    );
  }

  /// 底部区域
  _bottomWidget() {
    if (widget.bottomWidge != null) return widget.bottomWidge;
    return Container(
      height: 60,
      color: Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _btnWrap(title: '开发', onPressed: widget.btnTap1),
          _btnWrap(title: '调试', onPressed: widget.btnTap2),
          _btnWrap(title: '生产', onPressed: widget.btnTap3),
        ],
      ),
    );
  }

  // 按钮基础组件
  _btnWrap({@required String title, @required VoidCallback onPressed}) {
    return Container(
      width: 70,
      child: RaisedButton(
        color: Colors.white,
        child: Text(title),
        onPressed: () async {
          // _tabController.dispose();

          setState(() {
            flagTest = !flagTest;
            _initTabsWidget();
          });
          print('更新点击$flagTest');
          // if (onPressed != null) onPressed();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
