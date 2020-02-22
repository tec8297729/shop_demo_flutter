import 'package:baixing/components/PopupWinMenuButton/PopupWinMenuButton.dart';
import 'package:baixing/pages/HomeBarTabs/Home/provider/homeStroe.p.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'TopTitleScreeningMenu.dart';

const _textColor = Color(0xFF58A1BB);

class TopTitle extends StatefulWidget {
  TopTitle();
  @override
  _TopTitleState createState() => _TopTitleState();
}

class _TopTitleState extends State<TopTitle> {
  GlobalKey topTitleKey = GlobalKey();
  HomeStore homeStore;
  double topHeight; // 顶部距离
  int compreSortItemIndex; // 1、综合排序  2、距离  3销量  4筛选
  IconData compreSortIcon = Icons.keyboard_arrow_down;
  List compreSortDataList = [
    {
      'title': '综合排序',
      'isSelect': false,
    },
    {
      'title': '好评优先',
      'isSelect': false,
    },
    {
      'title': '起送价最低',
      'isSelect': false,
    },
    {
      'title': '配送最快',
      'isSelect': false,
    },
    {
      'title': '配送费最低',
      'isSelect': false,
    },
    {
      'title': '人均从低到高',
      'isSelect': false,
    },
    {
      'title': '人均从高到低',
      'isSelect': false,
    },
    {
      'title': '通用排序',
      'isSelect': false,
    },
  ];
  String compreSortSelectTitle;
  // 菜单弹层定位
  RelativeRect boxPosition = RelativeRect.fromLTRB(0, 0, 0, 0);

  @override
  void initState() {
    super.initState();
  }

  /// 当前标题点击高亮 1、综合排序  2、距离  3销量  4筛选
  handleSelectIndex(int index) {
    setState(() {
      compreSortItemIndex = compreSortItemIndex == index ? 1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    homeStore = Provider.of<HomeStore>(context);
    topHeight = homeStore.getTopHeight();
    boxPosition = RelativeRect.fromLTRB(0, homeStore.showTopTItleHeight, 0, 0);
    return Row(
      key: topTitleKey,
      children: <Widget>[
        headerCompreSortBtn(), // 综合排序>下拉菜单
        GestureDetector(
          onTap: () {
            handleSelectIndex(2);
          },
          child: Container(
            margin: EdgeInsets.only(left: 24),
            width: ScreenUtil().setWidth(80),
            child: titleBtnWidget('距离', index: 2),
          ),
        ),
        GestureDetector(
          onTap: () {
            handleSelectIndex(3);
          },
          child: Container(
            margin: EdgeInsets.only(left: 24),
            width: ScreenUtil().setWidth(80),
            child: titleBtnWidget('销量', index: 3),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerRight,
            child: heraderScreening(),
          ),
        ),
      ],
    );
  }

  /// 综合排序按钮
  Widget headerCompreSortBtn() {
    return GestureDetector(
      // 标题名称,默认显示 综合排序
      child: titleBtnWidget(
        compreSortSelectTitle ?? compreSortDataList[0]['title'],
        index: 1, // top系列整体索引,非当前数组索引
        icon: compreSortIcon,
      ),
      onTap: () {
        // topHeight = homeStore.getTopHeight();
        // 滚动位置
        homeStore.getHomeController.jumpTo(topHeight);

        // 更新icon图标及选中状态
        compreSortIcon = Icons.keyboard_arrow_up;
        handleSelectIndex(1);
        // 显示下拉菜单
        showWinMenu(
          context: context,
          position: boxPosition,
          elevation: 0,
          items: [
            for (var i = 0; i < compreSortDataList.length; i++)
              compreSortItem(i),
          ],
        );
      },
      onTapCancel: () {
        compreSortIcon = Icons.keyboard_arrow_down;
        handleSelectIndex(compreSortItemIndex);
      },
    );
  }

  /// 综合排序item子组件
  Widget compreSortItem(int index) {
    bool _isSelect = compreSortDataList[index]['isSelect'];
    return GestureDetector(
      onTap: () {
        for (var i = 0; i < compreSortDataList.length; i++) {
          compreSortDataList[i]['isSelect'] = false;
          if (i == index) {
            compreSortDataList[i]['isSelect'] = true;
          }
        }
        setState(() {
          compreSortSelectTitle = compreSortDataList[index]['title']; // 更换标题
        });
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.only(left: 25, right: 15, top: 10, bottom: 10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              compreSortDataList[index]['title'] ?? '',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: _isSelect ? _textColor : Colors.black,
              ),
            ),
            if (_isSelect)
              Icon(
                Icons.check,
                size: ScreenUtil().setSp(32),
                color: _textColor,
              ),
          ],
        ),
      ),
    );
  }

  /// 筛选按钮组件
  Widget heraderScreening() {
    return GestureDetector(
      child: titleBtnWidget(
        '筛选',
        index: 4,
        icon: Icons.filter_list,
        left: true, // 靠右对齐
      ),
      onTap: () {
        // 滚动位置
        homeStore.getHomeController.jumpTo(topHeight);
        handleSelectIndex(4);
        // 显示菜单
        showWinMenu(
          context: context,
          position: boxPosition,
          elevation: 0,
          items: [
            TopTitleScreeningMenu(),
          ],
        ).then((v) {
          // 关闭菜单
          handleSelectIndex(1);
        });
      },
      onTapCancel: () {
        handleSelectIndex(compreSortItemIndex);
      },
    );
  }

  /// iocn标题组件
  /// [index] 点击类型 1、综合排序  2、距离  3销量  4筛选
  Widget titleBtnWidget(String text,
      {int index = 1, IconData icon, bool left = false}) {
    Color _color = compreSortItemIndex == index ? _textColor : Colors.black;
    TextStyle _textStyle = TextStyle(
      fontSize: ScreenUtil().setSp(32),
      color: _color,
    );
    return Row(
      mainAxisAlignment: left ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Text(text, style: _textStyle),
        if (icon != null)
          Icon(
            icon,
            color: _color,
          ),
      ],
    );
  }
}
